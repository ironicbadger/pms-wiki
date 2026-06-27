# My Top 10 Self-Hosted apps

Once you have a server running 24/7 in your life, you'll quickly start wondering if there is more you can do with it. Replace video streaming services, or Google Drive, or host your own Home Automation system. Here's a list of some of my favorite self-hosted app picks.

The [awesome-selfhosted](https://github.com/awesome-selfhosted/awesome-selfhosted) list details [Free](https://en.wikipedia.org/wiki/Free_software) Software network services and web applications which can be hosted locally. There is also a [Non-Free](https://github.com/awesome-selfhosted/awesome-selfhosted/blob/master/non-free.md) page.

<p align="center">
<iframe src="https://player.fireside.fm/v2/dUlrHQih+KXqyZUPK?theme=dark" width="740" height="200" frameborder="0" scrolling="no"></iframe>
</p>

My YouTube channel - [KTZ Systems](https://www.youtube.com/@ktzsystems) - is still in its early days but I'm building a playlist of [self-hosted app spotlights](https://www.youtube.com/playlist?list=PLmaj94hXs3GG9yIc4nB5CdIBQ9nAays0I) you might enjoy.

## 1. Jellyfin

[Jellyfin](https://jellyfin.org/) is the media solution that puts you in control of your media. Stream to any device from your own server, with no strings attached. Your media, your server, your way.

![jellyfin-banner](../images/top10/jellyfin.png)

!!! info "JellyfinJune"
    For a deeper look at Jellyfin in 2026, see the [JellyfinJune](../jellyfinjune/index.md) companion notes, episodes and client guides.

Jellyfin serves no business model, and is not subject to the gradual enshitification that we've seen with Plex over the years. With no cloud connectivity required for authentication, no random streaming services and snappy performance - a fully featured, local first media server experience awaits. Did I mention that it's completely open source too?

It really is worth a look if you haven't tried it in a while. Client updates are coming thick and fast and the server side of things has improved hugely as well. Jellyfin is the future of media servers, no doubt. The KTZ Systems JellyfinJune series digs into the switch from Plex, Jellyfin 12 and the growing client ecosystem.

<p align="center">
<iframe width="740" height="415" src="https://www.youtube.com/embed/videoseries?list=PLmaj94hXs3GFbjVg5UkdnpmO_HxCIMOXM&index=1" title="JellyfinJune playlist on YouTube" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</p>

[Plex](https://plex.tv) is the reason you're even reading this page. It's what got me interested in Linux in the first place and is somewhat of a gateway drug for self-hosting and can be run as a [container](https://hub.docker.com/r/plexinc/pms-docker/). However, it is not open source and the general posture of Plex as a company gives me pause. They continue to add features and streaming services that [no-one asked for](https://www.reddit.com/r/PleX/comments/e62nbt/how_do_you_disable_the_new_plex_movies_feature/) - [or wants](https://old.reddit.com/r/selfhosted/comments/zw4k2h/what_has_plex_done_lately_that_you_didnt_like/).

**Similar or related projects:**

* [Plex](https://plex.tv)
* [Emby](https://emby.media/)
* [Kodi](https://kodi.tv/)

## 2. Home Assistant

![home-assistant-logo](../images/top10/ha-logo.png){: align=right width=200 }

Open source home automation that puts local control and privacy first. [Home Assistant](https://www.home-assistant.io/) is a truly remarkable project. At the time of writing it has over 3000 [integrations](https://www.home-assistant.io/integrations/) with all manner of devices, services and hardware supported. This is the true magic of Home Assistant.

A [demo](https://demo.home-assistant.io/#/lovelace/0) is available if you're curious to see it in action. But the real magic comes when you start automating your life to a point where when Home Assistant isn't there, you miss it. Automate the lights, climate control and yes, even your dog (via a bedtime routine) with Home Assistant!

A fantastic resource to learn more about the project is YouTube. [Everything Smart Home](https://www.youtube.com/@EverythingSmartHome), [The Hook Up](https://www.youtube.com/c/TheHookUp), [Intermit.tech](https://www.youtube.com/c/IntermitTech), [Smart Home Solver](https://www.youtube.com/@SmartHomeSolver) and [DigiblurDIY](https://www.youtube.com/c/digiblurDIY) are some of the most well-known channels. This isn’t an exhaustive list but should give you plenty of material to work with if you’re in need of inspiration or buying advice.

Home Assistant can be run as a standalone container, on a Raspberry Pi, as a VM and countless [other ways](https://www.home-assistant.io/getting-started/). The learning curve is real but this project really is worth your time to investigate.

## 3. Immich

![immich-logo](../images/logos/immich-logo-stacked-dark.svg){: align=right width=200 }

[Immich](https://immich.app/) is a self-hosted photo management and backup solution that is better at what it does than any of the major proprietary tech company owned solutions Whilst most people are OK with sending their photos off to the cloud for big-tech to process them, monetize them via AI and what have you, some of us aren't.

Immich does local machine learning on your images to do things like face detection, object search and more. I even [made a video](https://youtu.be/QHWNu_in0Zc?si=XHcfw8xnXwbFBM2B) about it for $dayjob showcasing remote machine learning with remote GPUs as well. The Self-Hosted podcast covered Immich extensively in [episode 110](https://notes.jupiterbroadcasting.com/self-hosted/2023/episode-110/) if you'd like to learn more. It's a really fantastic project and it's well worth a look.

Immich recently [joined FUTO](https://immich.app/blog/2024/immich-core-team-goes-fulltime/). I hope to see that this gives the project the runway it needs to really become the defacto open-source solution for photo management. I wrote about the options in 2021 for [Ars Technica](https://arstechnica.com/gadgets/2021/06/the-big-alternatives-to-google-photos-showdown/) and since then Immich has come out of nowhere.

## 4. Paperless-ngx

![paperless-ngx-logo](../images/logos/paperless-ngx-logo.svg){: align=right width=160 }

[Paperless-ngx](https://docs.paperless-ngx.com/) is a document management system that turns piles of PDFs, scans, receipts, manuals and letters into a searchable archive.

This is one of those apps that feels boring until it quietly becomes essential. Feed it documents from a scanner, email, mobile app or watched folder and it will OCR, tag, classify and store them. The payoff is being able to find that one warranty, tax letter or medical bill in seconds instead of digging through a drawer.

**Similar or related projects:**

* [Mayan EDMS](https://www.mayan-edms.com/)
* [Docspell](https://docspell.org/)

## 5. Nextcloud

![nextcloud-logo](../images/logos/nextcloud-logo.svg){: align=right width=170 }

[Nextcloud](https://nextcloud.com/) - The self-hosted productivity platform that keeps you in control.

Surely this pick needs no introduction. Think of Nextcloud somewhat like your own personal Dropbox replacement. Although, that is doing it a disservice because Nextcloud supports _many_ more features than Dropbox. Nextcloud provide a [demo](https://try.nextcloud.com) if you'd like to try before you "buy" (Nextcloud is free).

It can be a bit unreliable and unwieldy to administer at times - especially around update cycles. But once you get a working configuration it's a really handy tool.

[Nextcloud Hub](https://nextcloud.com/hub) brings together several key areas of functionality:

* [Nextcloud Files](https://nextcloud.com/files) - offers universal file access on desktop, mobile and web. Find files with powerful search, share your thoughts in comments or lock files until you are done with them.
* [Nextcloud Talk](https://nextcloud.com/talk) - delivers on-premises, private audio/video conferencing and text chat through browser and mobile interfaces with integrated screen sharing and SIP integration.
* [Nextcloud Groupware](https://nextcloud.com/groupware) - integrates Calendar, Contacts, Mail and other productivity features to help teams get their work done faster, easier and on your terms.

**Similar or related projects:**

* [Seafile](https://www.seafile.com/en/home/)
* [Filestash](https://github.com/mickael-kerjean/filestash)

## 6. Vaultwarden

<img class="top10-logo-light" alt="vaultwarden-logo" src="/images/logos/vaultwarden-logo.svg" align="right" width="220">
<img class="top10-logo-dark" alt="vaultwarden-logo" src="/images/logos/vaultwarden-logo-white.svg" align="right" width="220">

[Vaultwarden](https://github.com/dani-garcia/vaultwarden) is an unofficial Bitwarden-compatible server written in Rust. It provides the Bitwarden client experience with a much lighter server footprint, which makes it a popular choice for small self-hosted installs.

I would not put a password vault on the internet casually, but with HTTPS, backups, MFA and sensible access controls, Vaultwarden is one of the highest utility services you can run. Password management is exactly the kind of thing worth owning carefully.

**Similar or related projects:**

* [Bitwarden](https://bitwarden.com/)
* [KeePassXC](https://keepassxc.org/)

## 7. Caddy

<img class="top10-logo-light" alt="caddy-logo" src="/images/logos/caddy-logo.svg" align="right" width="220">
<img class="top10-logo-dark" alt="caddy-logo" src="/images/logos/caddy-logo-dark.svg" align="right" width="220">

Yes, I know. A reverse proxy isn't the most terribly exciting inclusion in this list but it is one of the most important. [Caddy](https://caddyserver.com/) is my current default recommendation for most self-hosters because it makes HTTPS boring in the best possible way.

Caddy's automatic HTTPS and simple Caddyfile syntax mean a reverse proxy can be configured in a few readable lines rather than a pile of labels or nested config. For a single home server, VPS, or small self-hosted stack, that simplicity is hard to beat.

Traefik is still powerful, especially when you want Docker provider integration and dynamic service discovery, but Caddy is the easier recommendation for people who want to expose a few services securely without turning the proxy into its own project.

**Similar or related projects:**

* [Traefik](https://traefik.io/traefik/)
* [nginx](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
* [PMS reverse proxy comparison](../04-day-two/remote-access/index.md)

## 8. Forgejo

![forgejo-logo](../images/logos/forgejo-logo.svg){: align=right width=150 }

A self-hosted, lightweight, and community-governed software forge, [Forgejo](https://forgejo.org/) is my current pick for hosting git repositories at home. It started as a soft fork of Gitea and keeps the same general shape: repos, users, organisations, issues, pull requests, packages and CI workflows without needing the resources of a full GitLab install.

One of my favourite features of this kind of forge is repository mirroring. You can automatically mirror remote git repositories locally when commits land upstream. This makes it easy to back up your own code, and other people's code, to your server. Because it's git the entire repo history is maintained and if for some reason a popular project became the target of a BS [DMCA claim](https://github.blog/2020-11-16-standing-up-for-developers-youtube-dl-is-back/), you're not up the creek without a paddle - so to speak.

Forgejo still occupies the sweet spot that made Gitea attractive in the first place: small footprint, familiar GitHub-style workflows, and enough features for home labs, small teams and community projects.

**Similar or related projects:**

* [Gitea](https://gitea.com/)
* [Gitlab](https://about.gitlab.com/)
* [Gogs](https://gogs.io/)

## 9. Beszel

![beszel-logo](../images/logos/beszel-logo.svg){: align=right width=120 }

[Beszel](https://beszel.dev/) is a lightweight server monitoring platform with a clean web UI, small agents, container stats, alerts and historical metrics.

It is not trying to replace a full Prometheus and Grafana stack for complex environments. That's part of the appeal. For a home server or a handful of boxes, Beszel gives you the kind of at-a-glance health view people actually want: CPU, memory, disk, network, Docker containers and simple alerts without building a monitoring platform before you can monitor anything.

**Similar or related projects:**

* [Grafana](https://grafana.com/)
* [Uptime Kuma](https://uptime.kuma.pet/)
* [Netdata](https://www.netdata.cloud/)

## 10. Karakeep

<img class="top10-logo-light" alt="karakeep-logo" src="/images/logos/karakeep-logo.png" align="right" width="220">
<img class="top10-logo-dark" alt="karakeep-logo" src="/images/logos/karakeep-logo-white.png" align="right" width="220">

[Karakeep](https://karakeep.app/) is a self-hosted bookmark and read-it-later app for links, notes and images. It saves pages, indexes their contents and gives you a private place to keep the kind of web clippings that otherwise end up scattered across browser profiles, chat windows and half-forgotten notes.

This category has been around forever, but Karakeep feels modern enough to make the list now. Full-text search, browser extensions, automatic tagging options and a clean UI make it a much better fit for the "save this for later" workflow than a folder of browser bookmarks.

**Similar or related projects:**

* [Linkwarden](https://linkwarden.app/)
* [Wallabag](https://wallabag.org/)

## Honorable mentions

* [Grafana](https://grafana.com/) remains the heavyweight pick for dashboards and time-series visualization, especially with Prometheus, Loki or InfluxDB behind it.
* [Smokeping](https://oss.oetiker.ch/smokeping/) is still excellent for long-term latency graphs, but Beszel is a better general-purpose monitoring pick for this list in 2026.
* [Librespeed](https://librespeed.org/) is still useful when you want a self-hosted speed test on your LAN or VPS.
* [Lychee](https://lychee.electerious.com/) is still a solid simple gallery app, but Immich is the stronger default recommendation for self-hosted photo management.

## Surprise me...

What are your favourites? Let me know [@ironicbadger](https://techhub.social/@ironicbadger) on Mastodon.
