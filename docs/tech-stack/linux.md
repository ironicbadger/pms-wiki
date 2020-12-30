# Linux

![linux](../images/linux.jpg){: align=left width=180 }

Ah, [Linux](https://linux.org). This game changing, pioneering, free and open source is the foundation upon which everything that PMS is, is built.

The project was founded in 1991 as a personal project by Linus Torvalds (hence the name Linux). Linux powers many of the worlds computers, is the basis of the Android kernel and is perhaps the ultimate unsung hero of modern computing times. Here is a full [history of Linux](https://en.wikipedia.org/wiki/History_of_Linux) if you're curious.

!!! info
    When we refer to "Linux", we are technically referring to the Linux kernel. 
    
    A "distribution" is the Linux kernel paired with the required packages to make a system boot, connect to the network, display video and so on.

## Which distro should I pick?

In the context of building PMS the choice is kind of made for you, if you're interested at all in using ZFS or WireGuard. Ubuntu is the only mainstream distribution which ships with both projects compiled into the kernel and doesn't rely on DKMS - see *ZFS -> [What about the license?](http://localhost:8000/tech-stack/zfs/#what-about-the-license)*.

Ubuntu isn't perfect. They make weird choices about pushing proprietary app packaging formats like SNAP [^1] that you can't easily disable[^2]. But their courage to ship ZFS, provide bi-annual LTS means that it has been a predictable, reliable and dependable long term option to build PMS on top of. 

The original incarnation of PMS used Debian. Ubuntu is derivative of Debian [^3] and besides from native WireGuard and ZFS support you can pretty use the two interchangeably - the choice is yours.

[^1]: [snapcraft.io](https://snapcraft.io/)
[^2]: [Disabling Snaps in Ubuntu 20.04](https://news.ycombinator.com/item?id=22972661)
[^3]: [Debian derivatives](https://www.debian.org/derivatives/)

*[LTS]: Long Term Support
*[PMS]: Perfect Media Server