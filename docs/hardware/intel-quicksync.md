# Intel Quick Sync

Media servers do not need to super power beasts of systems. Indeed, an 8th gen Intel CPU is what has been running in [Badger's Stack](../01-overview/high-level.md) for years now.

Quick Sync has been a game changing technology. It is a hardware media encoder built-in to most modern Intel CPUs. It's capable of encoding 2 or more 4K streams at once which is perfectly sufficent for most use cases.

## Performance

Performance per watt is class leading too. In our testing it draws 10w or less under full load and 0w at idle. Compare this to a discrete GPU which often requires 20w+ just to sit at idle, never mind under load! Then there's the upfront cost of hardware to support a discrete GPU. You need a motherboard with enough PCIe slots, PSU plugs, a big enough case, and so on. Having the media encoder built-in to the CPU is just so convienent!

## Playback

Modern applications for media playback like [Jellyfin](https://jellyfin.org/) and [Plex](https://jellyfin.org/) support QSV for hardware transcoding. Unfortunately Plex lock it behind a paid Plex Pass option but it is well supported.

More info [here](../advanced/passthrough-igpu-gvtg.md#plex-hardware-acceleration).