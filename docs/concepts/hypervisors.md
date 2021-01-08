# Virtualization and Containers

A hypervisor is an Operating System designed to primarily do one thing, run virtualisation workloads. That means virtual machines for the most part, though LXC and other containerisation methods are possible too with some hypervisors. 

Virtual machines let you carve up one system into many smaller ones. Containers divide a single VM into small, isolated pieces. The primary difference between a VM and a container is that they consume kernels differently. The kernel is the magic that translates software calls into commands hardware can understand. 

!!! info
    When we refer to "Linux", we are technically referring to the Linux kernel. 
    
    A "distribution" is the Linux kernel paired with the required packages to make a system boot, connect to the network, display video and so on.

Each new VM needs it's own, isolated kernel. Containers on the other hand, share one kernel. This means containers use the resources of a system much more efficiently. So surely, VMs are dead then?

## Do I need a hypervisor?

Possibly. 

It really depends on how you want to use this system. If you're just looking to store some files and run a few containers then a hypervisor might be a layer of added complexity that you just don't need. 

Couple that with the fact that the Linux kernel ships with a hypervisor built-in called KVM and you might have all the virtualisation you need already running *bare metal*. Bare metal meaning you install the OS directly onto the system.

However if you are looking to use this system as more of a homelab then running PMS as a VM on top of a hypervisor might make more sense. Let's say you are running Proxmox right now, a fully open-source Hypervisor, but for some reason work asks you to learn VMware you can [migrate VMs](https://blog.ktz.me/migrate-qcow2-images-from-kvm-to-vmware/) from one platform to the other quite easily.

We've just established portability as a key benefit of running on a hypervisor but what about flexibility? Have you ever been in a situation where you're trying to diagnose why a system won't boot remotely? Unless you have [IPMI](https://www.zenlayer.com/blog/what-is-ipmi/) accessing the console of your system remotely can be really tough. 

It's worth mentioning at this point that there are projects like [PiKVM](https://github.com/pikvm/pikvm) looking to change this. If running as a VM, console based triage is as simple as opening up another tab in your browser as shown below.

![proxmox](../images/proxmox-ui-tab.png)

### Flexibility

Continuing on the flexibility track for a moment we must also consider that not every application or service you might want to experiment with on your LAN is well suited to a container on your primary file serving VM. For example, something like Adguard Home or Home Assistant that needs access to common ports or specific hardware. It's much easier to test out Pihole and Adguard home side by side when you can spin up a couple of VMs in a few clicks.

Then there's snapshots and automation. By running as a VM we can take snapshots at the hypervisor level before any critical tasks like OS upgrades. Not only that, we can use a tools like Ansible or Terraform (see [concepts/infrastructureascode](infraascode.md)) to completely automate everything. Or, in the case of a failed upgrade, just rollback the snapshot and it'll be like nothing ever happened.

In our opinion, running as a VM has many, many upsides with only a couple of downsides. The first is that hardware requirements are usually a lot more onerous with virtualisation, especially VMware. Second, you will need to 'use up' a little of your hardware to run the hypervisor. Usually this is a minimal overhead - with something like Proxmox a couple of GBs of RAM and a dedicated CPU core to the hypervisor will suffice. With VMware you might want to consider running vSphere which needs 4-8gb of RAM but provides the API layer that Ansible and Terraform need to their thing.

Before deciding whether to virtualise or not, take a look at what is possible using [PCI passthrough](pci-passthrough.md). Virtualised routers, gaming rigs and much more is possible.

*[KVM]: Kernel Virtual Machine - linux-kvm.org
*[PMS]: Perfect Media Server
*[VM]: Virtual Machine