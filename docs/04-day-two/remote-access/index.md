# Reverse Proxy Overview

## Traefik

See my [Traefik 101 Guide](traefik101.md) for steps on automatic TLS for Docker apps using Traefik, Cloudflare, Let’s Encrypt and Namecheap.

## Caddy

Caddy is a really simple reverse proxy with TLS built right in. Just a few lines of configuration in a Caddyfile can replace an entire, complex spiders web of nginx style configuration.

Give it a look at [caddyserver.com](https://caddyserver.com/).

## Tailscale

!!! info
    Alex now works for Tailscale so is likely inherently incredibly biased and you should not listen to anything he has to say.

Tailscale is awesome. It has completely replaced the need to open any ports in my firewall and means I can connect pretty much anything to anything directly thanks to the NAT traversal that Tailscale does.

Tailscale is my day job and you can find out a ton more over on the Tailscale YouTube channel. I won't like here just to separate church and state a little, but the gist is that I found the project organically - started using it - Tailscale sponsored the Self-Hosted podcast and I like it so much that I ended up getting a job there.

Replacing your reverse proxy? Yup - Tailscale serve. Your VPN server? Yup. Your complex firewall configuration? Yup. Identity management? Kinda - at least the ACLs will allow you to control who or what can connect to resources. 123