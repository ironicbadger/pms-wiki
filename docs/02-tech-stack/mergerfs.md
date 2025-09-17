# mergerfs

The GitHub page describes mergerfs as "a featureful union filesystem ... geared towards simplifying storage and management of files across numerous commodity storage devices. It is similar to mhddfs, unionfs, and aufs".

This amazing project is developed and maintained by Antonio SJ Musumeci (aka [@_trapexit](https://twitter.com/_trapexit)). Back in 2019 I got the chance to speak with Antonio for an episode of [*Extras*](https://extras.show/) by [Jupiter Broadcasting](https://www.jupiterbroadcasting.com/) - if you're interested in this technology who better to hear about it from than the developer himself?!

<p align="center">
<iframe src="https://player.fireside.fm/v2/WTrMvATU+NSbz5Jst?theme=dark" width="740" height="200" frameborder="0" scrolling="no"></iframe>
</p>

## What is mergerfs?

mergerfs takes JBOD and turns them into what appears like a single drive. It's sort of like RAID in that sense but is actually nothing *at all* like RAID - there are some major differences - see ["is this RAID?"](#is-this-raid)

## Why mergerfs?

Here are the key features of mergerfs that make it perfect for PMS:

* Pools multiple drives into one mountable volume
* Supports addition *and* removal of devices with no rebuild times
* Permits drives with mismatched sizes with no penalties
* Each drive has an individually readable filesystem (ext4, xfs, zfs, etc)
    * Drives may contain data when mounted via Mergerfs
* Simple configuration with one line in `/etc/fstab`

For the home user the incremental addition of hard drives is a very important consideration. ZFS still lacks easy expandability and for most people, adding 4 or more drives at once is prohibitively expensive - see ["The hidden cost of ZFS"](http://louwrentius.com/the-hidden-cost-of-using-zfs-for-your-home-nas.html).

Drives of a useful capacity cost upwards of $150 (x4 = $600). $600 is a chunk of change to plop down in one go just because you filled up your last drive - why not have a system that grows as your needs do?

This doesn't take into consideration the increased simultaneous failure risk of buying 4 drives from the same batch (when drives go bad they usually fail at a similar point if from the same batch)! With mergerfs the drive addition process is as simple as partitioning the drive, adding it to the mount command in `/etc/fstab` and you’re done. 

I do however suggest considering your use case carefully. For example mergerfs is best suited to large, primarily write once read many datasets like media files. Last year I decided to start using a ZFS mirror for my most critical data and merging that using mergerfs as well - see [combining ZFS and mergerfs](../05-advanced/combine-zfs-and-others.md).

## Drive Pooling

In the following diagram there are five separate disks. Each disk is a different size, is formatted with differing filesystems and they may already contain data - all of this is fine for mergerfs.

![mergerfs-blue](../images/tech-stack/mergerfs-blue.png)

Configuration is performed via a single line of configuration in `/etc/fstab`[^1]. mergerfs has a lot knobs and dials to turn should you wish, they are all detailed in the [mergerfs-docs](trapexit.github.io/mergerfs).

!!! example "An example `/etc/fstab` entry for mergerfs"
    ```
    /mnt/disk* /mnt/storage fuse.mergerfs defaults,nonempty,allow_other,use_ino,cache.files=off,moveonenospc=true,category.create=mfs,dropcacheonclose=true,minfreespace=250G,fsname=mergerfs 0 0
    ```

The example above is the required configuration to take every drive which matches `/mnt/disk*` such as `/mnt/disk1` or `/mnt/disk95` and merge it together presenting it to the user at `/mnt/storage`.

!!! note
    The directories and names used (`disk1` or `/mnt/storage`) are completely arbitrary and can take any form you wish.

It's possible to string multiple drives together manually as well. The syntax for that is to place a single `:` between the path to each drive to be mounted like `/mnt/disk*:/mnt/tank/fuse:/mnt/usb`.

## Create policies

A fundamentally important part of having a successful experience with mergerfs is setting the correct [policies](https://trapexit.github.io/mergerfs/latest/config/functions_categories_policies/) for your use case. 

!!! info
    For most people, most of the time, the default behaviours will be just fine[^3].

The default create policy is `epmfs`. That is a path preserving algorithm. With such a policy for `mkdir` and `create` with a set of empty drives it will select only 1 drive when the first directory is created. Anything, files or directories, created in that first directory will be placed on the same branch because it is preserving paths.

This catches a lot of new users off guard but changing the default would break the setup for many existing users. If you do not care about path preservation and wish your files to be spread across all your drives change to `mfs`. 

!!! info
    Take a moment to read [this](https://github.com/trapexit/mergerfs/issues/634) issue on the mergerfs GitHub if you're a looking for more context on create policies - they can be a bit confusing to begin with.

    You might find the best all round option to use in your `/etc/fstab` entry for mergerfs is `category.create=mfs`. This will fill all disks at roughly the same rate but not colocate entire "blobs". In otherwords, episodes from the same TV show might end up all over all your disks - in practice this doesn't matter but it might matter to you if you're a neat freak.

If you do want path preservation you'll need to perform the manual act of creating paths on the drives you want the data to land on before transferring your data[^3].

## Is this RAID?

No, mergerfs differs from RAID in a few key ways.

The first is that mergerfs has *nothing whatsoever* to do with parity[^2]. mergerfs has **zero** fault tolerance - if the drive that data is stored on fails, that data is gone. With RAID if the fault tolerance of the array is exceeded all data is lost but with mergerfs only the failed drive is affected.

To add a parity like feature, mergerfs is often paired with [SnapRAID](snapraid.md). SnapRAID takes a snapshot of the data disks at a set interval providing some local redundancy. Whilst these two projects are complimentary to each other their relationship is coincidental.

Second is that mergerfs does not stripe data. RAID achieves a level of redundancy by placing enough data from each drive on each of the other drives such that it can compute what was on the drive that just failed. This is useful but with modern drives leads to long rebuild times which creates unnecessary wear and tear on the drives leading, ironically, to premature failure - often during the most critical time, a rebuild!

The third way is related to the second. Because data is not striped each disk remains individually readable. That means that you can pull any combination of drives and put them into *any other* system capable of reading that filesystem and it will just work. This is not possible without all the members of a RAID array.

## An example file layout

Here's an example of what mergerfs enables us to do. Take data spread out across multiple locations and present it to us as one location transparently.

```
alex@cartman:/mnt$ tree -L 2
.
├── disk1
│   ├── music
│   ├── photos
│   ├── movies
│   └── tv
├── disk2
│   └── movies
├── disk3
│   ├── drone
│   └── sports
└── storage
    ├── drone
    ├── movies
    ├── music
    ├── photos
    ├── software
    ├── sports
    └── tv
```

As you can see we now have data spread across multiple filesystems or physical disks that is merged transparently into `/mnt/storage` by mergerfs from drives with different filesystem. 

As discussed in [create policies](#create-policies), use of the correct create policy (the default of `epmfs` should suffice) in mergerfs is important to maintain this set up. The important part being `existing path` as without this option mergerfs will spread files out across multiple drives based on which has most free space.


[^1]: More information about `/etc/fstab` is detailed in the [manual installation](../03-installation/manual-install-ubuntu.md) section.
[^2]: [What is Parity?](https://en.wikipedia.org/wiki/Standard_RAID_levels#Simplified_parity_example)
[^3]: [trapexit/mergerfs docs](https://trapexit.github.io/mergerfs/latest/faq/why_isnt_it_working/#why-are-all-my-files-ending-up-on-1-filesystem)
