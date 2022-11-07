# Backups

When it comes to data, it is often said that one is none, and two is one. However, according to the [3-2-1 strategy](https://www.seagate.com/blog/what-is-a-3-2-1-backup-strategy/), three is one. The 3-2-1 backup strategy breaks down to these requirements.


- 3 copies of data 
- 2 different mediums
- 1 offsite copy

3 copies may seem excessive, but it provides the best redundancy against any sort of adverse situation you could find yourself in. Let's take a look at an example of an effective implementation of this strategy, which is how I backup my data.

I have three copies of my data in total. I have a ZFS mirror that copies the data across both drives, similar to RAID 0. This keeps a copy of my data on two different mediums, in the same case. However, this alone is not enough.

!!! NOTE: RAID is not a full backup!

While our data may be redundant, it's only protected from one angle. Mirroring data across two disks only preserves data if asingle drive fails. If both of those copies are lost, that data is lost. Electrical damage, natural disasters, fires, floods, all pose a risk to these mirrored pools. To mitigate this, one must keep their backups, or at the very least the most critical portions, offsite.

While many people use "cloud storage" solutions like Google Drive or DropBox, these plans are often on an expensive subscription based model. My logic is that since these are cold backups, and ideally should never need to be recovered from, cost should come as priority over things like egress speed. I've found [backblaze.com](backblaze.com) to be a good choice. Right now, I have about 250GB stored in their B2 buckets. At $0.005 GB/month, this comes out to about $1.25 a month. There are also egress costs, so if the worst were to happen and my disks were destroyed, it would cost me about 2.50 to recover all my most crucial files. I feel that's a fair price to pay for peace of mind.

# Tools

There are a multitude of tools that can be used to help keep and maintain redundant copies of data. For my primary mirrored copy, I use ZFS. These copies are maintained with monthly ``zfs scrub`` to prevent against bit rot. For offsite storage, I personally use (autorestic)[https://autorestic.vercel.app/], which provides an intuitive wrapper around restic. The pools are encrypted and then sent up to BackBlaze every hour.

Another popular option is rsync/rclone, a command-line utility that copies data between local and remote sources. It supports encryption and many different cloud providers.  

# Testing

Backups are no good if you can't restore from them. Make sure you test your backups regularly, especially after any changes to your strategy. Ensure that in event of an emergency, you can restore from any and all of your copies. There's nothing worse than losing something, going to your backup, and finding that it was corrupt or otherwise improperly stored.

For more information, check out Episode 20 of the Self-Hosted podcast, where Chris and Alex discuss these tools in more depth.

<iframe src="https://player.fireside.fm/v2/dUlrHQih+pywvrsnF?theme=dark" width="740" height="200" frameborder="0" scrolling="no"></iframe> 


