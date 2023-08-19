# Linux

![linux](../images/logos/linux.jpg){: align=right width=300 }

Ah, [Linux](https://linux.org). This game changing, pioneering, free and open source software is the foundation upon which everything that PMS is, is built.

The project was founded in 1991 as a personal project by Linus Torvalds (hence the name Linux). Linux powers many of the worlds computers, is the basis of the Android kernel and is perhaps the ultimate unsung hero of modern computing times. Here is a full [history of Linux](https://en.wikipedia.org/wiki/History_of_Linux) if you're curious.

!!! info
    When we refer to "Linux", we are technically referring to the Linux kernel. 
    
    A "distribution" is the Linux kernel paired with the required packages to make a system boot, connect to the network, display video and so on.

## Which distro should I pick?

In the context of building PMS you have two real choices. If you're at all interested in using ZFS, then Ubuntu is the only mainstream distribution which ships with it baked into the kernel and doesn't rely on DKMS - see *ZFS -> [What about the license?](zfs.md#what-about-the-license)*.

Ubuntu isn't perfect. They make weird choices about pushing proprietary app packaging formats like SNAP [^1] that you can't easily disable[^2]. But their courage to ship ZFS and provide bi-annual LTS means that it has been a predictable, reliable and dependable long term option to build PMS on top of.

[Proxmox](proxmox.md) is a dark horse here though. It's a bastardized version of debian and ubuntu smushed together with some "proxmox sauce" thrown in on top. This means you get ZFS support out the box, a VM and LXC hosting platform with a fully featured web interface and an API to automate tools like Ansible and Terraform against if that floats your boat. Combine that with Proxmox's ability to cluster multiple nodes together for failover, migration, and storage and it becomes quite a compelling option as a base OS for PMS.

There's no right or wrong answer here though. Ubuntu, Proxmox, Debian, NixOS, Arch, Tumbleweed, or whatever else will work just fine as a NAS. The main things to watch out for are software availability in a timely fashion (*cough, cough debian*) and whether you can stomach DKMS builds for things like ZFS or not. For what it's worth, I use Proxmox everywhere as the PMS baseOS in my homelab. Full details are available in [Alex's PMS Example Build](../01-overview/alexs-example-builds.md) if you're curious.

!!! info
    The original incarnation of PMS used Debian. Ubuntu is derivative of Debian [^3] and besides from native ZFS support you can pretty much use the two interchangeably - the choice is yours.

[^1]: [snapcraft.io](https://snapcraft.io/)
[^2]: [Disabling Snaps in Ubuntu 20.04](https://news.ycombinator.com/item?id=22972661)
[^3]: [Debian derivatives](https://www.debian.org/derivatives/)
