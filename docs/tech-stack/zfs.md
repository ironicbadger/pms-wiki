# ZFS

Use of ZFS with PMS is entirely optional. However, it does have some pedigree in keeping data safe and provides features for remote replication that prove useful when backing up. This article will cover the basics of ZFS for use with PMS. 

!!! info
    Use of ZFS with PMS is entirely optional. 
    
    See [combining ZFS with MergerFS](../advanced/combine-zfs-and-others.md) for full information on using ZFS alongside other filesystems thus avoiding "the hidden cost of ZFS"[^1].

## What is ZFS?

ZFS merges the traditional volume management and filesystem layers, and it uses a copy-on-write transactional mechanism—both of these mean the system is very structurally different than conventional filesystems and RAID arrays.

Jim Salter wrote a [ZFS 101](https://arstechnica.com/information-technology/2020/05/zfs-101-understanding-zfs-storage-and-performance/) piece for Ars Technica. It goes into excruciating detail but is a fantastic primer if you're curious to learn more.

Simply put, ZFS is the gold standard for storing data. You must pay attention when creating a ZFS vdev due to the lack of flexibility on offer[^1]. This is [due to change](https://twitter.com/mahrens1/status/1338876011161690112?s=20) with the *eventual* inclusion of RAIDZ expansion but at the time of writing this feature is not available.

<p align=center>
<img src="images/zfs-raidz-tweet.png">
</p>

## Why use ZFS for PMS?

Despite prior protest

## Creating a storage pool

## Replication basics



[^1]: [The Hidden Cost of ZFS for a Home NAS](https://louwrentius.com/the-hidden-cost-of-using-zfs-for-your-home-nas.html)

*[PMS]: Perfect Media Server