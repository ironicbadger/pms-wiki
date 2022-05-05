# Badger's Recommended Stack Rundown

A new page for May 2022, here's a high level overview snapshot of PMS as it stands today.

!!! info
    Access the living and breathing repository I use to configure all my infrastructure on GitHub at [ironicbadger/infra](https://github.com/ironicbadger/infra).

# Hardware

![motherboard](../images/asrockmobo.jpg)

| Device       | Model                                                  | Reason                                                                                                                     |
| ------------ | ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| CPU          | [Intel i5 8500](https://amzn.to/3LMgZBH)               | iGPU with built-in [Quicksync](../hardware/intel-quicksync.md) transcoding hardware                                        |
| Motherboard  | [ASRock Rack E3C246D4U](https://amzn.to/3LMh88d)       | IPMI + iGPU support. Full write-up [here](https://blog.ktz.me/asrock-rack-e3c246d4u-the-perfect-media-server-motherboard/) |
| Case         | [Rosewill RSV-L4500](https://amzn.to/37eVqKS)          | Pre-covid this case was often under $100 but at current prices of $200 and up, it's a tough recommendation                 |
| Memory       | [Corsair DDR4 64GB - Non ECC](https://amzn.to/3w8LWcN) | 64GB is enough to run my entire production stack without being tempted to use it as a dev environment too                  |
| Boot Drive   | [Samsung 500GB M.2 NVMe SSD](https://amzn.to/37kBI0l)  |                                                                                                                            |
| Power Supply | [Seasonic PRIME 850 Gold](https://amzn.to/3OXvMLP)     | Electricity makes computer go brrrrrr. 850w is probably overkill for this use case. 5-600w would be adequate.              |
| Hard Drives  | A mix of drives from 8-14tb                            | See [HDD purchasing methodology](../hardware/hdd-purchase-methodology.md) for more details                                 |


# Software

| Type              | Product / Version                                          | Reason                                               |
| ----------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| OS                | [Proxmox 7.2](../tech-stack/proxmox.md)                    | ZFS support and VM UI is nice to have.               |
| Parity            | [SnapRAID](../tech-stack/snapraid.md)                      | Increases uptime and fights bit-rot style corruption |
| Drive pooling     | [mergerfs](../tech-stack/mergerfs.md)                      | Present many disks under one mountpoint              |
| Container runtime | [docker](../tech-stack/docker.md)                          | Do I need a reason?                                  |
| VM                | [Home Assistant](../day-two/top10apps.md#3-home-assistant) |                                                      |
|                   |                                                            |                                                      |

# Containers

| Container                                        | Purpose                                    | Relevant content link                                            |
| ------------------------------------------------ | ------------------------------------------ | ---------------------------------------------------------------- |
| [Traefik](https://traefik.io/)                   | Reverse proxy                              | [Traefik 101 Guide](../remote-access/traefik101.md)              |
| [Authelia](https://www.authelia.com/)            | Basic auth frontend                        |                                                                  |
| [Flame](https://github.com/pawelmalak/flame)     | Dashboard                                  |                                                                  |
| [Plex](https://www.plex.tv/)                     | Media server                               | [Top 10 Apps - Plex](../day-two/top10apps.md#1-plex)             |
| [Tautulli](https://github.com/Tautulli/Tautulli) | Plex analytics                             |                                                                  |
| [Nextcloud](https://nextcloud.com/)              | An awesome self-hosted dropbox alternative | [Top 10 Apps - Nextcloud](../day-two/top10apps.md#2-plex)        |
| [Smokeping](https://oss.oetiker.ch/smokeping/)   | Latency measurement and graphing tool      | [Top 10 Apps - Smokeping](../day-two/top10apps.md#5-smokeping)   |
| [Librespeed](https://librespeed.org/)            | Self-hosted speedtest tool                 | [Top 10 Apps - Librespeed](../day-two/top10apps.md#7-librespeed) |

See my infra repo for a full list [here](https://github.com/ironicbadger/infra/blob/master/group_vars/morpheus.yaml#L275).