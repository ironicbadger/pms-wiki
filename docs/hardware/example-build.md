# An example build

We're looking for a build that meet a few important requirements:

- Power efficient - A system powered up 24/7 should sip the juice
- Hardware transcoding - Transcode movie files on the fly with Plex or Jellyfin
- Connect a lot of hard drives
- 

## Intel vs AMD

For a media server, it's really tough to beat Intel. That's because of the QuickSync media encoder built-in to the iGPU on almost all Intel CPUs of the last 5 years or so.



## What about Nvidia GPU hardware decoding?

[Nvidia NVENC](https://en.wikipedia.org/wiki/Nvidia_NVENC) is a poor choice for media servers unless you are compensating for picking the wrong CPU. The Nvidia cards use vast amounts of energy relative to an iGPU both under idle and load conditions. Up until recently GPU availability meant they were prohibitively expensive as well - we'll ignore price for now.

You'll also have a more difficult time with getting the hardware acceleration to work in the first place. For Nvidia cards to work with Plex or Jellyfin, you'll need to use a container which has their drivers built-in. Historically this has been a huge pain point although [Linuxserver.io - Plex](https://github.com/linuxserver/docker-plex#nvidia) makes it much simpler these days. This in contrast to getting an Intel iGPU to work with one line of configuration thanks to Intel drivers being built into the kernel - `--device=/dev/dri:/dev/dri`.

In general, if you can, avoid building a system around an Nvidia GPU (or any discrete GPU really). Intel ARC looks promising but my testing so far has shown there's a *long* way to go here.