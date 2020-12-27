# PCI Passthrough

A game changing technology that gives virtual machines *direct* access to the hardware, [PCI passthrough](https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF) enables VMs on the same system to have isolated hardware access. This means performance is broadly identical to if you were using that hardware on bare metal. There are a few key types of devices that are usually worth considering passing through such as SATA controllers, network interfaces and graphics cards. 

An example use case here might be running a media server VM with a disk controller passed through and another VM for an Opnsense firewall with a NIC card ([more on this in a moment](#an-example-using-opnsense)). Once inside the VM, the hardware will appear to all intents and purposes as if you were running on bare metal, Opnsense for example now has access to real NICs - so it just *works*. 

Passthrough is pretty amazing once you get your head around it and unlock the potential of this technology. One box can easily take the role of what used to be a dozen physical machines saving on power bills and hardware purchase costs. In this scenario though, just remember if you reboot your hypervisor for some reason it'll take out your internet too.

<iframe src="https://fireside.fm/player/v2/RUkczH-V+9ZRzR3sB?theme=dark" width="740" height="200" frameborder="0" scrolling="no"></iframe>

I recorded an episode of Linux Unplugged on the topic of passthrough in July 2019, it should clear up any confusion about how specific your hardware choices must be if going this route. That said, things are a little less picky nowadays than they used to be but it pays to thoroughly research components before purchase if this is your desired. Generally speaking, Xeon based systems will give you the least headache as passthrough is a key datacentre technology and is well supported on these platforms.

## An example using OPNsense

Everything is easier to understand with an example right? Let's say you'd like to replace your ISP provided firewall with something like [OPNsense](https://opnsense.org/), a free and open-source BSD firewall.

Typically, this would require a whole extra system running 24/7 to achieve. Low power systems have come a long way in recent years and idle at <15w but if you already have a system capable of PCI passthrough running why not use that instead? It saves you from buying another case, power supply, motherboard, RAM and set of disks.

Using passthrough it's very straightforward. Buy a dedicated PCIe NIC card, such as this [Intel Quad Gigabit NIC](https://amzn.to/3nVAknX) card (eBay might be cheaper), and use PCI passthrough to give the OPNsense guest full access. You won't notice any performance degradation in real terms and your only cost for the project was the NIC card.

In this specific use case, a Quad NIC gives more flexibility as the NICs are typically grouped in pairs. You will need two ports - 1 for WAN and 1 for LAN. This leaves you two spare ports for other projects.

*[NIC]: Network Interface Card