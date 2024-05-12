# Intel Quick Sync

Media servers do not need to super power beasts of systems. For example, an 8th gen Intel CPU ran in [Alex's Example PMS Build](../01-overview/alexs-example-builds.md) for years now although more recently an upgrade to a 13th gen Intel i5-13600k CPU took place.

Quick Sync (QSV) has been a game changing technology. It is a hardware media encoder built-in to most modern Intel CPUs and is capable of encoding 2 or more 4K streams at once which is perfectly sufficent for most use cases.

## Which CPU is the best?

Best is of course a subjective term. But over the first half over 2024, Alex and a big chunk of the self-hosting community ran hundreds of CPU tests to benchmark QSV in the first public test of its type. For full thoughts, see the [blog post](https://blog.ktz.me/the-best-media-server-cpu-in-the-world/).

<p align="center">
<img alt="igputop" src="../../images/hardware/igpu-cpu-graph.png">
</p>

## Performance

Performance per watt is class leading too. In our testing it draws 10w or less under full load and 0w at idle. Compare this to a discrete GPU which often requires 20w+ just to sit at idle, never mind under load! Then there's the upfront cost of hardware to support a discrete GPU. You need a motherboard with enough PCIe slots, PSU plugs, a big enough case, and so on. Having the media encoder built-in to the CPU is just so convienent!

## Playback

Modern applications for media playback like [Jellyfin](https://jellyfin.org/) and [Plex](https://jellyfin.org/) support QSV for hardware transcoding. Unfortunately Plex lock it behind a paid Plex Pass option but it is well supported.

More info [here](../05-advanced/passthrough-igpu-gvtg.md#plex-hardware-acceleration).