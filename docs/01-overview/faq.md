Here are some of the most commonly asked questions about building a media server.

## Can I migrate existing data from another NAS software?

Yes.

[mergerfs](../02-tech-stack/mergerfs.md) makes this really easy, even if your data disks already have data on them. The only caveat is that each disk must already be formatted with its own filesystem - no pre-filled striped storage (RAID, ZFS, etc).

## Should I run PMS on the host directly, or as a VM?

This is really up to you. Unless you have a really compelling reason to run PMS as a VM (I'm assuming with disk controller passthrough), then run it all directly on the host system - in my case, [proxmox](../02-tech-stack/proxmox.md).

I used to advocate for running everything in a VM to keep the host OS clean. However a few years ago, with the advent of Quick Sync and just how performant and energy efficient it is for transcoding media, it made sense to ditch this model and run at least Jellyfin (or Plex) on the host itself. Passing through an iGPU to a VM is difficult and unreliable, and [gvt-g](../05-advanced/passthrough-igpu-gvtg.md) - the act of taking one iGPU and splitting it up in multiple virtual GPUs for multiple VMs - is even more unreliable and the performance sucks.

Keeping the hypervisor host clean would be more ideal but the trade off is worth it. Almost all apps run as containers anyway, so there aren't any messy app dependencies on the host, except docker if that even counts! Storage is in the hypervisor OS so it can be used for VMs without internal bridges or file sharing set up required. It just makes everything a little bit simpler doing it this way.

Alex runs a Home Assistant VM, a couple of LXCs (for Pihole and as a Tailscale exit node) and everything else, including docker, goes directly onto the host.

## What performance can I expect?

How fast can your disks write? The limiting factor for performance is the drive itself. With a modern mechanical drive this is typically anywhere from 130MB/s - 220MB/s read/write speeds. SSDs start at 5-600MB/s and only go up from there.

Unraid works around poor write performance, due to the way its parity system works, with the use of cache drives. I have never found the need to do this with PMS. 

## What types of data should I store on mergerfs?

[mergerfs](../02-tech-stack/mergerfs.md) is best suited to storing data that you write once and read a few times, like media. Technically, it will work with smaller files and other use cases but that isn't where it shines.

Careful consideration should be given to moving busier workloads like databases and download extraction to a dedicated SSD elsewhere in the system, perhaps as a ZFS mirror.

## What type of Hard Drive should I buy?

There is no one right answer to this question. Ask 10 folks on [r/datahoarder](https://www.reddit.com/r/DataHoarder/) and you will recieve 37 different answers! That said, there are some principals to follow when purchasing a drive and I cover my methodology in the 2019 PMS edition but have added a dedicated article on this under *Hardware -> [HDD Purchase Methodology](../06-hardware/hdd-purchase-methodology.md)*.

