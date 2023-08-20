## FAQ

Here are some of the most commonly asked questions about building a media server. If you feel one is missing, please open a GitHub issue and/or tweet me [@IronicBadger](https://twitter.com/ironicbadger).

### Can I migrate existing data from another NAS software?

Yes. As long as you're not using a proprietary RAID solution then [mergerfs](../02-tech-stack/mergerfs.md) makes this really easy as it will mount drives that already contain data and supports pretty much any reasonable filesystem you can think of.

### What performance can I expect?

I am easily able to saturate a gigabit link because of the way each drive is treated as an individual unit. The limit of performance is the limit of the drive itself. With a modern mechanical drive this is typically anywhere from 130MB/s - 220MB/s read/write speeds.

Some NAS software works around poor write performance with the use of cache drives but I have never found the need to do this with PMS. With careful consideration about moving busier workloads like databases and download extraction to a dedicated SSD the read/write performance of the NAS itself is gigabit speed+.

### What type of Hard Drive should I buy?

There is no one right answer to this question. Ask 10 folks on [r/datahoarder](https://www.reddit.com/r/DataHoarder/) and you will recieve 37 different answers! That said, there are some principals to follow when purchasing a drive and I cover my methodology in the 2019 PMS edition but have added a dedicated article on this under *Hardware -> [HDD Purchase Methodology](../06-hardware/hdd-purchase-methodology.md)*.

## Archived FAQs

### Why Ubuntu Desktop instead of Ubuntu Server?

!!! info 
    This FAQ / recommendation was retired in January 2023. As of Ubuntu 22.04 the issue below is no longer present and drives are presented correctly once again.

The original PMS installation was on top of Debian and drives are presented using `/dev/disk/by-id/ata-*`, this holds true on the desktop variant of Ubuntu as well. But for some reason that I have not been able to determine Ubuntu Server presents the exact same drives, connected to the exact same HBA card - the only difference Desktop vs Server - as `/dev/disk/by-id/scsi-SATA_*`.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">OK - this is fun. Ubuntu 18.04 presented hard disks as `/dev/disk/by-id/ata-blah` but 20.04 seems to go for `/dev/disk/by-id/scsi-SATA_blah`. Same hardware with HBA passed through in ESXI, why does this happen anyone?</p>&mdash; Alex Kretzschmar (@IronicBadger) <a href="https://twitter.com/IronicBadger/status/1284339126473564162?ref_src=twsrc%5Etfw">July 18, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Ubuntu Desktop behaves the same way as Debian whereas Ubuntu Server does things it's own way. When moving between Proxmox, Ubuntu etc it's more convenient for me to be able to rely on the drives being presented the same way between the various spins. Therefore, I stick to Debian or Ubuntu Desktop.

You are welcome to use Ubuntu Server and deal with this minor inconvience if you wish but I chose to remain with the Desktop varaint for simplicities sake until I can get a straight answer on *why* this difference occurs - not just coping with the fact that it does.
