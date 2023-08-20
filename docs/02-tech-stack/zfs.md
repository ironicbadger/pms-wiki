# ZFS

Use of ZFS with PMS is entirely optional. However, it does have some pedigree in keeping data safe and provides features for remote replication that prove useful when backing up. This article will cover the basics of ZFS for use with PMS. 

!!! info
    Use of ZFS with PMS is entirely optional. 
    
    See [combining ZFS with MergerFS](../05-advanced/combine-zfs-and-others.md) for full information on using ZFS alongside other filesystems thus avoiding "the hidden cost of ZFS"[^1].

## What is ZFS?

ZFS merges the traditional volume management and filesystem layers, and it uses a copy-on-write transactional mechanism—both of these mean the system is very structurally different than conventional filesystems and RAID arrays.

Jim Salter wrote a [ZFS 101](https://arstechnica.com/information-technology/2020/05/zfs-101-understanding-zfs-storage-and-performance/) piece for Ars Technica. It goes into excruciating detail but is a fantastic primer if you're curious to learn more.

Simply put, ZFS is the gold standard for storing data. You must pay attention when creating a ZFS vdev due to the lack of flexibility on offer[^1]. This is [due to change](https://twitter.com/mahrens1/status/1338876011161690112?s=20) with the *eventual* inclusion of RAIDZ expansion but at the time of writing this feature is not available.

<p align=center>
<img src="../../images/tech-stack/zfs-raidz-tweet.png">
</p>

## Why use ZFS for PMS?

PMS is used to store all sorts of data ranging from easily replacable files to absolutely irreplaceable data such as photos, documents and drone footage. These files were created over a lifetime and they should outlast me. ZFS has checksumming[^2] [^3] to detect data corruption during reads, automatic corruption repair and replication corruption protection.

ZFS will do a lot to try and protect my data as long as I keep the hard drives healthy.

Container appdata is a fantastic use case for ZFS in a PMS system. ZFS datasets provide a simple way to version the configuration and persistent data for containers. Create a dataset per container and before making any drastic changes take a snapshot. If you screw something up, revert the snapshot.

## What about the license?

It is true, the ZFS and Linux licensing schemes are famously incompatible.

!!! quote
    And honestly, there is no way I can merge any of the ZFS efforts until I get an official letter from Oracle that is signed by their main legal counsel or preferably by Larry Ellison himself that says that yes, it's ok to do so and treat the end result as GPL'd.

    Other people think it can be ok to merge ZFS code into the kernel and that the module interface makes it ok, and that's their decision. But considering Oracle's litigious nature, and the questions over licensing, there's no way I can feel safe in ever doing so.

    And I'm not at all interested in some "ZFS shim layer" thing either that some people seem to think would isolate the two projects. That adds no value to our side, and given Oracle's interface copyright suits (see Java), I don't think it's any real licensing win either.

    Don't use ZFS. It's that simple. It was always more of a buzzword than anything else, I feel, and the licensing issues just make it a non-starter for me.

    \- Linus Torvalds [^5]

Despite this, Ubuntu has been shipping ZFS baked in since 2016 and the world has not ended. Efforts by Canonical to improve ZFS support are on-going as they recently added experimental support for ZFS on root. My experience with ZFS on Ubuntu has been solid - it just works.

The fact remains that ZFS is technically an out of tree module and either requires running a distro like Ubuntu willing to incur the legal wrath of Oracle or for the user to use DKMS[^4]. DKMS is unfortunately not super reliable in my experience and I avoid it wherever possible.

Ultimately whether or not this "risk" fits within your personal values is up to you.

## What about BTRFS?

Fedora recently adopted[^6] BTRFS as the default so it must be ready for primetime right?

!!! quote
    The Btrfs community has users that have been using it for most of the past decade at scale. It's been the default on openSUSE (and SUSE Linux Enterprise) since 2014, and Facebook has been using it for all their OS and data volumes, in their data centers, for almost as long. Btrfs is a mature, well-understood, and battle-tested file system, used on both desktop/container and server/cloud use-cases. We do have developers of the Btrfs filesystem maintaining and supporting the code in Fedora, one is a Change owner, so issues that are pinned to Btrfs can be addressed quickly.

Using BTRFS *would be easier* than ZFS simply because it is shipped as part of the Linux kernel. 

Perhaps one day PMS will switch out to BTRFS but that day is a ways off yet - ZFS is here to stay for now if for no other reason than I have replicated multiple TBs of data reliably for a year+ with no data loss whatsoever. In otherwords, I'm locked in.

## Creating a storage pool

!!! info
    I originally wrote an article on this topic for the LinuxServer.io blog [here](https://blog.linuxserver.io/2019/05/14/getting-started-with-zfs-on-linux/).

This article assumes you are using Ubuntu. We'll be creating a mirrored pair of drives for use with ZFS here. For reasons why you should use mirrors see [Jim's](https://jrs-s.net/2015/02/06/zfs-you-should-use-mirror-vdevs-not-raidz/) blog.

* Begin by installing the userspace tools for ZFS:

```
apt install zfsutils-linux
```

* Create a mirrored pair using the drive `by-id` idenifiers 
    * Make sure to set `ashift` correctly as below

```
zpool create tank mirror -m /mnt/tank -o ashift=12 /dev/disk/by-id/ata-ST10000DM0004-2GR11L_serial /dev/disk/by-id/ata-WDC_WD100EMAZ-00WJTA0_serial
```

!!! warning
    Never use `/dev/sdX` for these commands, always use a unique identifier that will transpose between systems or reboots without changing such as `/dev/disk/by-id/`. See the [OpenZFS docs](https://openzfs.github.io/openzfs-docs/Project%20and%20Community/FAQ.html#selecting-dev-names-when-creating-a-pool-linux) for more information.

* Once created verify the new pool with `zpool status`

```
alex@cartman:~$ zpool status
  pool: tank
 state: ONLINE
  scan: scrub repaired 0B in 0 days 12:16:03 with 0 errors on Sun Dec 13 12:40:04 2020
config:

	NAME                                    STATE     READ WRITE CKSUM
	tank                                    ONLINE       0     0     0
	  mirror-0                              ONLINE       0     0     0
	    ata-ST10000DM0004-2GR11L_serial     ONLINE       0     0     0
	    ata-WDC_WD100EMAZ-00WJTA0_serial    ONLINE       0     0     0

errors: No known data errors
```

* Create some datasets - do not store any data in the root of the pool

```
# list zpools
$ zpool list
NAME   SIZE  ALLOC   FREE  EXPANDSZ   FRAG    CAP  DEDUP  HEALTH  ALTROOT
tank  9.06T  2.51T  6.55T         -     1%    27%  1.00x  ONLINE  -

# create datasets
$ zfs create tank/appdata # takes format of pool/dataset/name
```

* Take a snapshot of the new dataset with `zfs snapshot`

```
# create snapshot
$ zfs snapshot pool/dataset@snapshotname
# or for a recursive (all dirs under this dataset) snapshot
$ zfs snapshot -r pool/dataset@snapshotname
```

* View snapshots with `zfs list -t snapshot`

```
# list snapshots
$ zfs list -t snapshot
NAME                                 USED  AVAIL  REFER  MOUNTPOINT
tank/appdata@20190506-2300           400M      -  5.67G  -
tank/appdata@080519-1430             111M      -  5.88G  -
tank/fuse@20190502-0900              112K      -   144K  -
tank/fuse/audiobooks@20190502-0900   317M      -  83.6G  -
```

* Finally ensure the dataset mountpoint is set as you require

```
$ zfs create -o mountpoint=/mnt/point tank/dataset/to/mount
```

## Tuning ashift

Jim Salter's blog at jrs-s.net[^7] has a number of excellent posts about ZFS including some about tuning in addition to his Ars Technica article [^8]. 

You must make sure you set `ashift` correctly. Disks often lie about their sector size and if you ignore this setting it can drastically degrade performance. Most large drives have 4k sectors so an `ashift=12` is usually fine. Some Samsung SSD have 8k sectors where `ashift=13` would be required.

<blockquote class="twitter-tweet" align="center"><p lang="en" dir="ltr">Ashift is per-vdev and immutable once set. It cannot be set at any level below the vdev.</p>&mdash; Jim Salter (@jrssnet) <a href="https://twitter.com/jrssnet/status/1123723278017757185?ref_src=twsrc%5Etfw">May 1, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## Maintenance

Scrubs are an important safety check to prevent bitrot. Ubuntu automatically schedules these for you.

<blockquote class="twitter-tweet" align="center"><p lang="en" dir="ltr">New blog post about my new adventures with ZFS.<a href="https://t.co/gmGESknfL1">https://t.co/gmGESknfL1</a><br><br>Thanks <a href="https://twitter.com/allanjude?ref_src=twsrc%5Etfw">@allanjude</a> and <a href="https://twitter.com/jrssnet?ref_src=twsrc%5Etfw">@jrssnet</a> for the drive to actually, finally do this.</p>&mdash; Alex Kretzschmar (@IronicBadger) <a href="https://twitter.com/IronicBadger/status/1128326518046887938?ref_src=twsrc%5Etfw">May 14, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

View the status of a pools scrubs with `zpool status`.

```
alex@cartman:~$ zpool status
  pool: tank
 state: ONLINE
  scan: scrub repaired 0B in 0 days 12:16:03 with 0 errors on Sun Dec 13 12:40:04 2020
config:

	NAME                                    STATE     READ WRITE CKSUM
	tank                                    ONLINE       0     0     0
	  mirror-0                              ONLINE       0     0     0
	    ata-ST10000DM0004-2GR11L_serial     ONLINE       0     0     0
	    ata-WDC_WD100EMAZ-00WJTA0_serial    ONLINE       0     0     0

errors: No known data errors
```

## Replication basics

One of the most compelling reasons to use ZFS is replication. We get more into the weeds of backups in **Day Two -> [Backups](../04-day-two/backups.md)** but this section will focus on the ZFS specific `zfs send/receive` functionality using [Sanoid](https://github.com/jimsalterjrs/sanoid) and Syncoid.

!!! hint
    Replication requires a remote system also running ZFS. I built a small system at a parent's house under the stairs to perform this function.
    
    [rsync.net](https://rsync.net) is expensive but provides this functionality 'in the cloud'.


[^1]: [The Hidden Cost of ZFS for a Home NAS](https://louwrentius.com/the-hidden-cost-of-using-zfs-for-your-home-nas.html)
[^2]: [Bonwick, Jeff (December 8, 2005) - "ZFS End-to-End Data Integrity"](https://en.wikipedia.org/wiki/ZFS#cite_note-endtoend-30)
[^3]: [Checkums and Their Use in ZFS](https://openzfs.github.io/openzfs-docs/Basic%20Concepts/Checksums.html)
[^4]: [DKMS - Arch Wiki](https://wiki.archlinux.org/index.php/Dynamic_Kernel_Module_Support)
[^5]: [Linus Torvalds ZFS Mailing List Rant](https://www.realworldtech.com/forum/?threadid=189711&curpostid=189841)
[^6]: [Changes/BtrfsByDefault](https://fedoraproject.org/wiki/Changes/BtrfsByDefault)
[^7]: [Jim Salter's Blog - ZFS category](https://jrs-s.net/category/open-source/zfs/)
[^8]: [ZFS 101 - Ars Technica](https://arstechnica.com/information-technology/2020/05/zfs-101-understanding-zfs-storage-and-performance/)
