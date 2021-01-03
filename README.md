# ironicbadger/pms-wiki

You can find the full site at [perfectmediaserver.com](https://perfectmediaserver.com).

## Abstract

Perfect Media Server began life as a series of blog posts over at [blog.linuxserver.io](https://blog.linuxserver.io/tag/perfectmediaserver/). Those posts continue to be very popular but a blog post can only get you so far, I therefore introduce perfectmediaserver.com - a wiki format information repository detailing all you need to know to build a free, open and modular media server that will last for many, many years.

The primary technologies we recommend are [Linux](https://www.linux.org/), Containers (via [docker](https://www.docker.com/) and managed using [docker-compose](https://docs.docker.com/compose/)), [Proxmox](https://www.proxmox.com/en/), [MergerFS](https://github.com/trapexit/mergerfs/), [SnapRAID](http://www.snapraid.it/) and [ZFS](https://zfsonlinux.org/).

You can find the original blog series of PMS here:

- [Perfect Media Server (2016 Edition) - The Original Article](https://blog.linuxserver.io/2016/02/02/the-perfect-media-server-2016/)
- [Perfect Media Server (2017 Edition) - Extensive video guides](https://blog.linuxserver.io/2017/06/24/the-perfect-media-server-2017/)
- [Perfect Media Server (2019 Edition) - Boring is reliable + adding ZFS](https://blog.linuxserver.io/2019/07/16/perfect-media-server-2019/)
- [Perfect Media Server (2020 Edition) - Launching perfectmediaserver.com](https://blog.ktz.me/the-perfect-media-server-2020-edition/)

If you're looking to build a media server, then you've come to the right place. This site documents the many aspects of building a media server using Free and Open Source Software wherever possible. 

## Using this repo

If writing and wanting to run a local copy of the wiki then run:

    docker-compose up --build

To deploy the site, push to `main` and a GitHub action will do the rest.

To contribute, open a PR. Gratefully received!
