# Automatic TLS 101 for Docker in 2021 - Using Traefik v2, Cloudflare, Let’s Encrypt and Namecheap

In this article we will be discussing reverse proxies, how they will enable you to securely expose webapps running on your LAN to the outside world and how to automate TLS (SSL) certificates using Let's Encrypt, Traefik, Cloudflare and Namecheap.

## Overview

There are quite a few moving parts to this operation but in essence, it's a simple transaction.

Traefik is the brains of the operation here. It is responsible for detecting when new containers have been created, communicating with Let's Encrypt to request a certificate to be issued and talking with Cloudflare by creating domain ownership verification records.

![traefik-tls-arch-diagram](../images/traefik101/traefik-tls-arch-diag.png)


### Pre-requisites

This guide assumes a few things are in place:

* You own your own domain such as "perfectmediaserver.com", purchasing a .com domain costs as little as $10 per year.
* You have a Cloudflare account to use as your DNS provider
* You have a single host running docker and a few containers

Traefik works best with a single primary container host. Those containers should be running on the same host you intend to run Traefik on. Not in a VM, not on a remote host, but the same OS. This is because Traefik watches the docker socket (the main entrypoint for the docker API) for changes so it knows when a container has been created, modified or destroyed. 

!!!warning
    There are some security concerns to mounting the docker socket this way, so make sure you [understand the risks](https://raesene.github.io/blog/2016/03/06/The-Dangers-Of-Docker.sock/) and are aware of the [workarounds](https://chriswiegman.com/2019/11/protecting-your-docker-socket-with-traefik-2/) before proceeding.

### Traefik

The first component of this architecture is [Traefik], a reverse proxy. The job of a reverse proxy is to listen for incoming requests, match that request to a rule, go get the requested content and finally serve it back to the user. This process is entirely transparent to the user and appears as if the target service is responding directly to you.

![reverse-proxy-digram](../images/traefik101/reverseproxy.png)

!!! info
    Traefik supports numerous [providers](https://doc.traefik.io/traefik/https/acme/#providers) for DNS challenge verification, but we will only be discussing Cloudflare in the scope of this article. You are to use others, but will need to adjust these steps according to Traefik's provider documentation.





Next let's examine the lifecycle of a container exposed via Traefik with a certificate issued by Let's Encrypt.


https://doc.traefik.io/traefik/providers/docker/#provider-configuration
providers.docker.endpoint=unix:///var/run/docker.sock