## FAQ

Here are some of the most commonly asked questions about building a media server. If you feel one is missing, please open a GitHub issue and/or tweet me [@IronicBadger](https://twitter.com/ironicbadger).

### What about unRAID, OpenMediaVault or FreeNAS?

I plan on writing a full comparison between these 3 but the primary difference is that when running PMS you built it. You know what went into each area, you have full control and it is running 100% free and open-source software.

### Can I migrate existing data from another NAS software?

Yes. As long as you're not using a proprietary RAID solution then [MergerFS](../tech-stack/mergerfs.md) makes this really easy as it will mount drives that already contain data and supports pretty much any reasonable filesystem you can think of.

### What performance can I expect?

In my household gigabit is the target. I am easily able to saturate a gigabit link because of the way each drive is treated as an individual unit the limit of performance is the limit of the drive itself. With a modern mechanical drive this is typically anywhere from 130MBs - 220MBs read/write speeds.

Some NAS software works around poor write performance with the use of cache drives but I have never found the need to do this with PMS. With careful consideration about moving busier workloads like databases and download extraction to a dedicated SSD the read/write performance of the NAS itself is gigabit speed+.

### What type of Hard Drive should I buy?

There is no one right answer to this question. Ask 10 folks on [r/datahoarder](https://www.reddit.com/r/DataHoarder/) and you will recieve 37 different answers! That said, there are some principals to follow when purchasing a drive and I cover my methodology in the 2019 PMS edition but have added a dedicated article on this under *Hardware -> [HDD Purchase Methodology](../hardware/hdd-purchase-methodology.md)*.

### What is `ext4lazyinit`?

!!! info
    Original credit: Thomas-Krenn Wiki [^1]

When creating an Ext4 file system, the existing regions of the inode tables must be cleaned (overwritten with nulls, or "zeroed"). The "lazyinit" feature should significantly accelerate the creation of a file system, because it does not immediately initialize all inode tables, initializing them gradually instead during the initial mounting process in background (from Kernel version 2.6.37). Regarding this see the extracts from the mkfs.ext4 man pages:[^2]

> If enabled and the uninit_bg feature is enabled, the inode table will not be fully initialized by mke2fs. This speeds up file system initialization noticeably, but it requires the kernel to finish initializing the file system in the background when the file system is first mounted. If the option value is omitted, it defaults to 1 to enable lazy inode table zeroing.

One should be careful when testing the performance of a freshly created file system. The "lazy initialization" feature may write a lot of information to the hard disk after the initial mounting and thereby invalidate the test results. At first, the "ext4lazyinit" kernel process writes at up to 16,000kB/s to the device and thereby uses a great deal of the hard disk’s bandwidth (see also Linux System Activity Information[^3]()). In order to prevent lazy initialization, advanced options are offered by the mkfs.ext4 command:[^2]

    mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0 /dev/mapper/fc-root

By specifying these options, the inodes and the journal will be initialized immediately during creation.

## Archived FAQs

### Why Ubuntu Desktop instead of Ubuntu Server?

!!! warning This FAQ / recommendation was retired in January 2023. As of Ubuntu 22.04 the issue below is no longer present and drives are presented correctly once again.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">OK - this is fun. Ubuntu 18.04 presented hard disks as `/dev/disk/by-id/ata-blah` but 20.04 seems to go for `/dev/disk/by-id/scsi-SATA_blah`. Same hardware with HBA passed through in ESXI, why does this happen anyone?</p>&mdash; Alex Kretzschmar (@IronicBadger) <a href="https://twitter.com/IronicBadger/status/1284339126473564162?ref_src=twsrc%5Etfw">July 18, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

The original PMS installation was on top of Debian and drives are presented using `/dev/disk/by-id/ata-*`, this holds true on the desktop variant of Ubuntu as well. But for some reason that I have not been able to determine Ubuntu Server presents the exact same drives, connected to the exact same HBA card - the only difference Desktop vs Server - as `/dev/disk/by-id/scsi-SATA_*`. 

Ubuntu Desktop behaves the same way as Debian whereas Ubuntu Server does things it's own way. When moving between Proxmox, Ubuntu etc it's more convenient for me to be able to rely on the drives being presented the same way between the various spins. Therefore, I stick to Debian or Ubuntu Desktop.

You are welcome to use Ubuntu Server and deal with this minor inconvience if you wish but I chose to remain with the Desktop varaint for simplicities sake until I can get a straight answer on *why* this difference occurs - not just coping with the fact that it does.

[^1]: [Thomas Krenn Wiki - Ext4 Filesystem](https://www.thomas-krenn.com/en/wiki/Ext4_Filesystem)
[^2]: [ext4 manpage](https://linux.die.net/man/8/mkfs.ext4)
[^3]: [Thomas Krenn Wiki - Linux System Activity Information](https://www.thomas-krenn.com/en/wiki/Collect_and_report_Linux_System_Activity_Information_with_sar?xtxsearchselecthit=1)