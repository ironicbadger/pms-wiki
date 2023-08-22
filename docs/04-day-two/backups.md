# Backups

When it comes to data, it is often said that one is none, and two is one. However, according to the [3-2-1 strategy](https://www.seagate.com/blog/what-is-a-3-2-1-backup-strategy/), three is one. 

## Implementation

The 3-2-1 backup strategy breaks down to these requirements:

- 3 copies of data 
- 2 different mediums
- 1 offsite copy

3 copies may seem excessive, but it provides excellent redundancy against adverse situations. Let's take a look at an example of an effective implementation of this strategy.

The first copy is stored on a ZFS mirror, similar in concept to RAID 0. This keeps complete copies of the data on both drives in a mirrored fashion. While data is redundantly copied between to the two drives protecting from one single drive failure, if both drives were to fail at the same time the data is irrevocably lost. Therefore, it is necessary to have additional copies of the data to protect against other potential risks such as electrical damage, natural disasters, fires, and floods.

!!! warning
    RAID of any form is NOT a backup! Only multiple physical copies following the 3-2-1 rule are a true backup. RAID is often incorrectly conflated with being a backup however it is designed to increase uptime not prevent data loss in and of itself.

To mitigate these risks, it is considered good practice to store your most critical data offsite. Many options exist in this space such as [zfs.rent](https://zfs.rent), [backblaze](https://backblaze.com), [AWS Glacier](https://aws.amazon.com/s3/storage-classes/glacier/), and so on - do your research and pick which has a good privacy policy, encrypts your data and is affordable (watch out for those retrieval fees!).

While many people use subscription-based services such as Google Drive or DropBox, the author has chosen to use backblaze.com due to its low cost. The author currently has approximately 250GB of data stored in Backblaze's B2 buckets at a cost of $0.005 GB/month, or approximately $1.25 per month. In the event that the worst were to happen and the author's disks were destroyed, it would cost approximately $2.50 to recover all of their most crucial files.

The third copy can be a little tricky. Copy 1 is local. Copy 2 is cloud. Copy 3? Another cloud? That's up to you. Consider asking a family member to host a small low power system that you can replicate to via something like [tailscale](https://tailscale.com) and [restic](https://restic.net/) (configured via [autorestic])https://autorestic.vercel.app)).

## Tools

It's a good idea to use a different technology for each layer. For example use ZFS replication for both copy 2 and copy 3 leaves you susceptible to issues with that specific tooling causing all backups to fail. Therefore a sane approach is to use ZFS replication for copy 2 and something like restic for copy 3. That means you have a block level copy (ZFS send) and a file level copy (restic). Two completely different, unrelated technologies.

If using ZFS as the primary data store see tools like [Sanoid](https://github.com/jimsalterjrs/sanoid) are invaluable for replicating data automatically.

Restic supports replicating to S3. Hosting your own Minio S3 API compatible object storage server is very straightforward and cost effective on a remote system.

## Testing

Backups are no good if you can't restore from them. Make sure you test your backups regularly, especially after any changes to your strategy. This ensures that in event of an emergency, you can restore from any and all of your copies. There's nothing worse than losing something, going to your backup, and finding that it was corrupt or otherwise improperly stored.

!!! warning
    It's a good idea to have a reminder every few months to test these backups. Pick a random file or two and attempt to restore it. Did it work?

For more information, check out Episode 20 of the Self-Hosted podcast, where Chris and Alex discuss these tools in more depth.

<p align="center">
<iframe src="https://player.fireside.fm/v2/dUlrHQih+pywvrsnF?theme=dark" width="740" height="200" frameborder="0" scrolling="no"></iframe> 
</p>
