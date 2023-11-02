# SnapRAID

[SnapRAID](https://www.snapraid.it/) provides us some basic protection against drive failures and pairs well with [mergerfs](mergerfs.md). Perhaps confusingly, you don't need one for the other to fuction.

You can use mergerfs without SnapRAID. And you can use SnapRAID without mergerfs. mergerfs *merges* multiple drives together for access under a single mountpoint. SnapRAID calculates parity to recover data if a drive fails. They work well together to replicate a similar type of "JBOD parity" system as unraid uses. The difference here being that unraid does the parity calculations in real-time (and therefore seriously hurts write performance) vs SnapRAID which does the calcuations on a timed basis every *X* time period.

For most PMS deployments, your media will be spread across a handful of JBOD drives merged together with [mergerfs](mergerfs.md). Without SnapRAID if a drive were to fail, you'd instantly lose all data on the failed drive forever. With SnapRAID you're able to rebuild that failed drive using parity data from your last snapshot. This approach is uniquely well suited to large, static datasets like media libraries. It is not well suited to fast moving data like your Plex metadata for example.

<p align="center">
<img alt="mergerfs-snapraid-diagram" src="../../images/tech-stack/diagram-mergerfs-snapraid.png" width="525">
</p>

## What is SnapRAID?

SnapRAID[^1] is a free and open-source project licensed under GPLv3 which calculates parity information for disk arrays and will protect against up to 6 disk failures at once. It essentially takes JBOD and provides a cohesive glue for them protecting against drive failure and bitrot. It is primarily targeted at media center users with lots of big files that rarely change. 

It supports mismatched disk sizes although the parity drive must be as large or larger than the largest data disk (see diagram above). Uniquely, it runs across a plethora of OS’s such as Linux, OS X, Windows, BSD, Solaris and OpenIndiana – pretty impressive.

The name SnapRAID comes from the fact that it isn't really RAID at all, it's "snapshot RAID". No striping occurs and parity information is devoted to entire dedicated parity disks. This implementation is a major difference from unRAID or traditional RAID (mdadm, ZFS, etc) all of which calculate parity in ‘real-time’ (unRAIDs cache drive system is an exception).

The project provides a handy comparison chart of how SnapRAID stacks up against the other options in this space[^2].

## Why SnapRAID?

In the PMS [overview](../01-overview/index.md#the-requirements) we laid out a number of requirements, let's take a look and see which of those SnapRAID will fulfill.

* Provide fault tolerance to protect against (inevitable) hard drive failure
* Checksum files to guard against bitrot
* Support hard drives of differing / mismatched sizes
* Enable incremental upgrading of hard drives in batches as small as one
* Each drive should have a separately readable filesystem with no striping of data

SnapRAID helps us meet each of these criteria and when combined with mergerfs enables each drive to remain individually formatted (no striping) whilst still having some kind of fault tolerance. Data integrity is checked for bitrot using 128bit checksumming which enables the silent fixing of these errors. Furthermore, any files changed since the last sync can be restored on a file by file basis allowing for quite a sophisticated backup solution at the file level.

It will also work on already populated data drives, a big win over traditional RAID. Again, it allows only the drives in use to be spun up unlike RAID which requires all drives spinning to access a file on one drive.

The first recorded instance of this saying was found in a cave in France and dates back thousands of years - RAID is not backup. Do not think that because you have a local parity setup that your data is backed up. What happens if a pipe burst or a burgler stole the whole thing or zombies came to dinner? We cover more details on proper backups in *Day Two -> [Backups](../04-day-two/backups.md)*.

## Is SnapRAID right for me?

Maybe. It depends on your use case.

As we've said, SnapRAID was designed with large, mostly static datasets in mind like media collections. A common use case is a media or home file server. Let’s say you have a 2TB collection of movies and a 2TB of TV shows, how often does that content change? Not very, is probably the answer. Does it therefore make sense to require real-time parity calculation or just run that computation once daily at a quiet time?

Here’s an example, you acquire a file and save it to disk called ‘BestMovieEver.mkv’. This file sits on disk and is immediately available as usual but until you run the parity sync the file is unprotected. This means if in between your download and a parity sync and you were to experience a drive failure, that file would be unrecoverable. It is simple to run a manual parity sync if required using `snapraid sync`.

Please review your use case before using SnapRAID. It is incredibly badly suited to high turnover applications such as databases or other similar applications. If this is your use case, look at a real-time parity based solution. If you can cope with this ‘risk window’ and have a largely static file collection, SnapRAID is for you.

## What about SnapRAIDs drive pooling?

SnapRAID offers a drive pooling feature that on the face of it looks like it makes mergerfs superfluous to requirements. However, the pooling feature by SnapRAID creates a read only virtual view of the files in your array using symbolic links and is therefore unsuitable for real usage.

## Using SnapRAID with mergerfs and ZFS

If, like me, you have a large collection of media files *and* some more high churn datasets then consider the more advanced implementation detailed in *Advanced Configurations -> [Using ZFS with mergerfs](../05-advanced/combine-zfs-and-others.md)*. This combines a SnapRAID protected array of data disks and a ZFS mirror to have the cake and eat it too.

[^1]: [snapraid.it](https://www.snapraid.it/)
[^2]: [SnapRAID compared](https://www.snapraid.it/compare)
