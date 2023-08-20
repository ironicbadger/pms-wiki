# Installation

You are at a cross-roads and must pick a path, it's time to pick an OS. Everyone has a different set of requirements but if in doubt it is my recommendation that you proceed with Proxmox.

In the context of building PMS you have two real choices. If you're at all interested in using ZFS, then Ubuntu is the only mainstream distribution which ships with it baked into the kernel and doesn't rely on DKMS - see *ZFS -> [What about the license?](../02-tech-stack/zfs.md#what-about-the-license)*.

Ubuntu isn't perfect. They make weird choices about pushing proprietary app packaging formats like SNAP [^1] that you can't easily disable[^2]. But their courage to ship ZFS and provide bi-annual LTS means that it has been a predictable, reliable and dependable long term option to build PMS on top of.



Ultimately, there's no right or wrong answer. Ubuntu, Proxmox, Debian, NixOS, Arch, SUSE, or whatever else will work just fine as a NAS. The main things to watch out for are software availability in a timely fashion (*cough, cough debian*) and whether you can stomach DKMS builds for things like ZFS or not. For what it's worth, I use Proxmox everywhere as the PMS baseOS in my homelab. Full details are available in [Alex's PMS Example Build](../01-overview/alexs-example-builds.md) if you're curious.

!!! info
    The original incarnation of PMS used Debian. Ubuntu is derivative of Debian [^3] and besides from native ZFS support you can pretty much use the two interchangeably - the choice is yours.



## Proxmox

[Proxmox](../02-tech-stack/proxmox.md) is the PMS defacto base OS these days. It's a bastardized version of debian and ubuntu smushed together with some "proxmox sauce" thrown in on top. This means you get ZFS support out the box, a VM and LXC hosting platform with a fully featured web interface and an API to automate tools like Ansible and Terraform against if that floats your boat. Combine that with Proxmox's ability to cluster multiple nodes together for failover, migration, and storage and it becomes quite a compelling option as a base OS for PMS.

## NixOS

[NixOS](../02-tech-stack/nixos.md) is brand new to me and PMS for 2023. It's a marked change in the way of approaching Linux and system configuration and it isn't ready for everyone yet. 

The documentation is lacking in key areas - namely Flakes - due to a glacial pace of governance and an abdundance of caution when making radical changes to the configuration structure of the system. This sound like negatives but in the long run, they aren't. The downside is it means right now, the new NixOS user experience is a bit messy.

!!! success "Is NixOS the right choice for me?"
    NixOS is the right choice for you if:

    1. You enjoy a simple, declaratively configured system
    2. You enjoy writing code or are already a developer
    3. You don't mind sharp edges when it comes to cryptic error messages and lacking documentation
    4. Repeatable builds matter to you
    5. You're just curious

## Ubuntu

[Ubuntu](https://ubuntu.com) is the old default installation for PMS. These days however, Proxmox is the default choice. This is due to being more aligned with the types of things we're more likely to do with a headless server such as running containers, VMs and not using this system as a desktop.

The "old" [manual installation guide for Ubuntu](manual-install-ubuntu.md) remains public mostly for posterity and because it's insanely detailed covering every step of building an Ubuntu system from scratch.

!!! success "Is Ubuntu the right choice for me?"
    Ubuntu is the right choice for your PMS installation if:

    1. You're already running it and are happy with it
    2. You want a faster update cycle than Proxmox provides
    3. You like the 2 year LTS release cadence
    4. You need ZFS without resorting DKMS
    5. You don't mind Snaps being part of a server OS
    6. You don't mind Canonical marketing to you in the terminal


[^1]: [snapcraft.io](https://snapcraft.io/)
[^2]: [Disabling Snaps in Ubuntu 20.04](https://news.ycombinator.com/item?id=22972661)
[^3]: [Debian derivatives](https://www.debian.org/derivatives/)