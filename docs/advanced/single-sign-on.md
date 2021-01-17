# Using Vouch Proxy as Single Sign On solution with Nginx and Traefik

Hosting a lot of services will mean remembering a lot of passwords. Using the same password for all services that require one would ease the process a bit. It would however still require you to manually change each password in each GUI or docker-compose file. Wouldn't it be nice if it was possible to use a single authentication scheme for all the applications running on your server? 

There are a few different usecases for SSO like protecting servcies without authentication. The wp_admin.php page of a WordPress is bombarded by spammers all the time. Putting a second layer in place might be a good solution. 

## Nginx auth-request module and the Traefik ForwardAuth middleware
![traefik-forwardauth](https://doc.traefik.io/traefik/assets/img/middleware/authforward.png)
These add-ons act as a gatekeeper to block non-authenticated requests. Authentication is done with an external (to the proxy) AuthServer. The AuthServer can be as simple as a webpage returning http-statuscode 200 for OK. This is not usefull as it would just let everything through. A more sensible AuthServer would be Vouch Proxy. 

## Vouch Proxy
> An SSO solution for Nginx using the [auth_request](http://nginx.org/en/docs/http/ngx_http_auth_request_module.html) module. Vouch Proxy can protect all of your websites at once.

That's at least what their GitHub page claims. If you should use it on all services is a different story. Some services have authentication build-in which you can disable (Syncthing) while some need authentication to at least set up a user-profile (Jellyfin). Some make it very difficult to disable (Deluge) and others don't even ship with authentication on purpose (Gossa).

Vouch lets you use external (to the server) login providers as well as some local providers. You can use Google or GitHub to login to your own services. This guide will primarily focus on Google/GitHub and Gitea in conjuction with Nginx as gatekeeper. Other providers are mentioned on the Vouch GitHub page and one should be able to use Traefik as the interface with the AuthServer is the same as Nginx. 

## Installation Vouch
!!! info
    This guide assumes the Nginx auth_request module is installed by default or that the user build Nginx with the module.

I like to use docker-compose so I put a docker-compose.yml file in my /srv/vouch/ directory:
```
version: '3.0'
services:
    vouch1:
      container_name: vouch_domain
      image: voucher/vouch-proxy
      ports:
       - 9090:9090
      volumes:
       - './config:/config'
       - './data:/data'
      restart: unless-stopped
```

The vouch.domain.com Nginx config is nothing special. I use Certbot to fix my SSL:
```
#/etc/nginx/sites-available/vouch.domain.com.conf
server {
        server_name vouch.domain.com;
        location / {
            proxy_pass         http://127.0.0.1:9090;
            proxy_set_header Host $http_host;
        }


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/vouch.domain.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/vouch.domain.coml/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
server {
    if ($host = vouch.domain.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    server_name vouch.domain.com;
    listen 80;
    return 404; # managed by Certbot
}
```

## Vouch config with Google/GitHub
Example files are available on the [Vouch Github page](https://github.com/vouch/vouch-proxy/tree/master/config).

## Vouch config with Gitea
Gitea is a self-hosted Git service with a low footprint. It also comes with a build-in [OAuth2 provider](https://docs.gitea.io/en-us/oauth2-provider/) and easy user-management. Even if you don't need the Git part, it is an excellent login provider. 
Setting up Gitea is similair to Vouch as it also has a Docker container available. I've exposed Gitea on the auth.domain.com subdomain as that's its primary function in my usecase.

First create an OAuth2 Application in Gitea. This can be done in the Gitea web-interface: Go to Settings -> Application -> Manage OAuth2 Applications. Give the application a name `Vouch-Domain` and set the Redirect URI to `https://vouch.domain.com/auth`. Copy the Client ID and Client Secret for use later. 

Then we need to configure Vouch, this can be done in the /srv/vouch/config/config.yml file:
```
vouch:
  logLevel: info
  testing: false

  listen: 0.0.0.0
  port: 9090

  allowAllUsers: true
  publicAccess: false

  jwt:
    secret: SomeLongGeneratedRandomString
    issuer: Vouch
    # number of minutes until jwt expires
    maxAge: 240
    # compress the jwt
    compress: true

  cookie:
    # name of cookie to store the jwt
    name: HelloWorldCookie
    domain: domain.com
    secure: true
    httpOnly: true
    # Set cookie maxAge to 0 to delete the cookie every time the browser is closed.
    maxAge: 240

  session:
    # name of session variable stored locally
    name: VouchSessionDomain
    key: SomeOtherLongGeneratedRandomString

  headers:
    jwt: X-Vouch-Token
    querystring: access_token
    redirect: X-Vouch-Requested-URI
    claims:
      - groups
      - given_name

  test_url: http://domain.com

oauth:
  provider: github
  client_id: 5c496697-4b21-464c-9f46-xxxxxxxxx
  client_secret: JFuiOg5_3K8qxnhYTYzhVwaO4_xxxxxxxxxxx=
  callback_url: https://vouch.domain.com/auth
  auth_url: https://auth.domain.com/login/oauth/authorize
  token_url: https://auth.domain.com/login/oauth/access_token
  user_info_url: https://auth.domain.com/api/v1/user?token=
```

## Using applications with Vouch
I will be using Jackett in this example as it's easy to setup and has no password protection by default. Jacket will be exposed on the jack.domain.com subdomain. 
This is the configuration I use and it might not be optimal. Take what you need from the condif file. 

```
#/etc/nginx/sites-available/jack.domain.com.conf
server {
    server_name jack.domain.com;
    auth_request /validate;
    client_max_body_size 0;
    client_body_temp_path /srv/tmp;

    location = /validate {
        # /validate proxies all the requests to lasso
        # lasso can also run behind the same nginx-revproxy
        proxy_pass http://127.0.0.1:9090/validate;
        proxy_set_header Host $http_host;

        # vouch only acts on the request headers
        proxy_pass_request_body off;
        proxy_set_header Content-Length "";

        # valid user!
        # add X-Vouch-User to the request
        auth_request_set $auth_resp_x_vouch_user $upstream_http_x_vouch_user;

      auth_request_set $auth_resp_jwt $upstream_http_x_vouch_jwt;
      auth_request_set $auth_resp_err $upstream_http_x_vouch_err;
      auth_request_set $auth_resp_failcount $upstream_http_x_vouch_failcount;

    }

    # if validate returns `401 not authorized` then forward the request to the error401block
    error_page 401 = @error401;

    location @error401 {
       return 302 https://vouch.domain.com/login?url=$scheme://$http_host$request_uri&vouch-failcount=$auth_resp_failcount&X-Vouch-Token=$auth_resp_jwt&error=$auth_resp_err;
    }


    location / {
        proxy_set_header X-Vouch-User $auth_resp_x_vouch_user;
        proxy_pass_header  Server;
        proxy_set_header   Host $http_host;
        proxy_redirect     off;
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   X-Scheme $scheme;
        proxy_pass         http://127.0.0.1:9117;
    }

    listen 443 ssl; # managed by Certbot
}
```

## Debugging
Everything's ready now! Browse to jack.domain.com and you'll probably be served by an error or "too many redirects". Change `testing: false` to `testing: true` in the Vouch config and try to figure out where you went wrong. Most of the time it's a non-existing end-point. In the debug window the 301 redirects are displayed as links you can manually click. It took me a while to figure out how it worked.  
