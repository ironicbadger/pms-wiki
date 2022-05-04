# NAS Software Comparison

This page serves as an opinionated comparison between the main players in the Home NAS space.

## unRAID

!!! quote
    Unraid OS allows sophisticated media aficionados, gamers, and other intensive data-users to have ultimate control over their data, media, applications, and desktops, using just about any combination of hardware.

[UnRAID ](https://unraid.net/) is perhaps the obvious alternative to PMS and indeed it does serve this niche incredibly well. The project has a long track record of supporting the product and has a [community](https://unraid.net/community) around it that is truly second to none.

However, unRAID is not open-source. It is also a paid product - there is nothing inherently wrong with people charging money for software they support. Like with Apple products you are paying for someone else to make decisions for you and unRAID has a very opinionated way of doing things.

## OpenMediaVault

!!! quote
    openmediavault is the next generation network attached storage (NAS) solution based on Debian Linux. It contains services like SSH, (S)FTP, SMB/CIFS, DAAP media server, RSync, BitTorrent client and many more. Thanks to the modular design of the framework it can be enhanced via plugins.

[openmediavault](https://www.openmediavault.org/) is open-source, based around Debian and has been regularly updated for years. It is capable of providing every feature that PMS does *and* provides a webUI. The project does a lot of things right and is a notable contender in this comparison and is for the most part the work of one developer, votdev. Incredible stuff.

<p align="center">
<img alt="omv-github" src="../../images/omv-github.png">
</p>

That said, for a GUI to be worth learning it has to be meaningfully better than the alternative by reducing complexity or being eye-candy. Unfortunately, OMV fails on both fronts. Sadly the UI looks dated and each time I've tried to use the project over the years I've come away frustrated by the extra complexity it adds. 

<p align="center">
<img alt="omv-ui" src="../../images/omv-ui.png">
</p>

This pervasive frustration was also the case as a new user. Something that could be configured in a few lines of a config file required navigating a UI and doing a whole lot of clicking. As a more experienced administrator these days I have embraced automation via [Ansible](../concepts/infraascode.md#ansible) and can rebuild a server in 15 minutes from scratch. Managing a server entirely via the CLI might seem intimidating at first but it's really the way to go. Yes, even via mobile using JuiceSSH on Android or blink on iOS - see [remote access](../remote-access/index.md).

OpenMediaVault is just Linux underneath though which is a good thing. This means it runs docker, supports ZFS (via DKMS), SnapRAID and MergerFS too. 

## Proxmox

!!! quote
    Proxmox VE is a complete open-source platform for enterprise virtualization. With the built-in web interface you can easily manage VMs and containers, software-defined storage and networking, high-availability clustering, and multiple out-of-the-box tools on a single solution.
  
[Proxmox](https://proxmox.com) is a well-known alternative to operating systems like UnRAID and ESXi. It is a free and open-source product with a fairly large community. The UI is well designed and has all the features you are likely to need. It won't have as many features as paid alternatives, but overall it will have most features you will need. Especially since proxmox has a great cli interface where you can script and get access to advanced features. Proxmox is built on top of Qemu and KVM and in my experience has been very reliable in keeping my VM's up and running. They also have a commercial plan that they will push you towards for more support, etc but for home use the community repos are just fine. It even has ZFS support and is based on Debian. Overall Proxmox is a pretty great solution if you are looking to run VM's for your media server and run other software as well.

*[PMS]: Perfect Media Server
*[webUI]: Web User Interface (GUI)