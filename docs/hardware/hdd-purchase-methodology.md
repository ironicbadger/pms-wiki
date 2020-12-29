# Hard Disk Drive Purchasing Methodology

!!! info
    This is a snippet from the [2019 edition](https://blog.linuxserver.io/2019/07/16/perfect-media-server-2019/) of Perfect Media Server.

It is a fact of life that some mechanical hard drives are created more equal than others. The manufacturing tolerances involved are microscopic and transportation is a high risk time for any drive. For these reasons I try to follow some rules when purchasing drive(s).

## The Rules

* Only ever purchase one drive per retailer per 3-6 months
* Distribute makes, models and manufacturers where possible and rational
* Never buy naked drives from Amazon - they come wrapped in tracing paper

### Rule #1 - Split up purchases

Rule #1 is designed to split your purchase across HDD manufacturing batches.

As with anything mass produced, hard drives are made in batches and some have (much) higher failure rates than others. By purchasing from multiple retailers you will be paying a little extra for shipping but the potential hassle saved in the long run of multiple drives from the same batch suffering a catastrophic failure at the same time will more than make up for a few $$$ in the long run.

Several years ago Seagate suffered a high failure rate on 1.5TB drives. Just imagine if you had purchased several of these drives and placed them in your box. The drives are even more likely to fail at the same time because they're exposed to the same (or very similar) environmental conditions, vibration and workloads as each other. So if there's a bug and you find it, you may well find it on all your drives within a few days or weeks of each other. With drive capacities heading northward of 10TB, that's a LOT of data to go poof.

### Rule #2 - Spread the risk

Rule #2 suggests splitting makes, models and manufacturers where possible.

For many of the same reasons just discussed it may be prudent over the long term to do this. You never know what cost cutting program a particular manufacturer is performing right now and nor will you until it's too late. You just don't know whether a new model from HGST is going to have a better lifespan than a WD model or the equivalent Seagate. We can speculate, and the internet does love to do so. To coin a phrase from the stock market, past performance is no indicator of future reliability and therefore brand loyalty should not enter your purchasing decisions.

Many people in the r/datahoarder community and other related communities have suffered at the hands of Seagate over the years (myself included). This was especially true around the time of the Thailand floods a few years ago when rampant cost cutting led to poor QC and ultimately a poor product. For this reason you'll still see many people absolutely swear blind they'll never buy a Seagate ever again. I was one of them for a while until Seagate released their 8TB SMR (shingled) drives for the same price as WD wanted for a 6TB Red. When it's only one drive in a system it's a pretty decent way to test the waters. In the 18 months since I purchased that Seagate SMR 8TB drive, it's been one of the best performers in my system with low temperatures when operating and great performance for media. Time will tell but so far, so good.

### Rule #3 - The retailer matters

Rule #3 is obvious. Don't buy naked drives from Amazon. I have twice due to competitive prices and low shipping ordered drives from Amazon, ignoring my own advice. Alas, on both occasions the drives were wrapped in a single layer of cardboard with no padding and on one occasion the drive had a visible dent in the casing. 

I never even bothered trying to power that one up. It was returned immediately. Save yourself the hassle and don't buy drives from Amazon.

<img src="../../images/naked-drive.jpg" align="center">

These rules happen to tie in nicely (surprise!) with some of my other overall thoughts on putting together the perfect media server and a topic I covered in the 2016 article. Namely, home users (the primary target for this series) probably don't want to have to buy 3+ drives at a time - it's just too much money to spend in one go! The ability to organically grow a system as your content collection, drone footage or linux ISO stash does is an absolutely core tenet and a key reason why I don't think any solution which requires adding more than one drive at once (going full ZFS, for example) is a suitable solution for most people, most of the time. By growing the system organically you not only put less pressure on your budget up front but you also potentially increase the overall reliability of the system thanks to Rule #1 and Rule #2.

If you needed another reason; the longer you wait, the more TBs you'll get for the same cash. 2 years ago I tried to 'standardise' on 6TB drives. The time came 6 months ago when I wanted to add another drive to my system and for the same money per drive I could now furnish my system with an 8TB model. Backblaze, purveyors of the excellent "Annual failure rate" series, have this interesting take on cost per gigabyte.

The general takeaway from this is that you should never buy a hard drive because in 6 months you'll be able to get significantly more for your money. Of course, this is a reality of any tech. At some point you've just got to bite the bullet and press the purchase button - but you get my point, I hope.

## Shucking

I'll keep this section brief as there is a load of information readily available over at the [r/datahoarder](https://www.reddit.com/r/DataHoarder/) subreddit. Suffice to say that Western Digital frequently offer 8TB drives for under $150 either via Amazon or Best Buy. You may ignore Rule #3 because these are retail drives and ship with appropriate packaging around the all important hard drive.

<figure>
    <iframe src="https://player.fireside.fm/v2/dUlrHQih+KIq7N1it?theme=dark" width="740" height="200" frameborder="0" scrolling="no"></iframe>
    <figcaption><i>Skip to 3.44 for our coverage of drive shuckin'.</i></figcaption>
</figure>

You might find yourself needing to either modify your power cables to get around the 3.3v detection fix on WD drives. WD obviously want you paying top dollar for your drives and so have enabled in the firmware a 3.3v detection dead mans switch. The fix is easy. Either A) apply kapton tape to the pins - detailed here or B) cut the 3.3v wire on your sata connectors. Not all PSUs are affected and it's really not a big deal. See below, I made some custom power cables which omit the 3.3v rail altogether - problem solved.

<p align="center">
<img src="../../images/custom-power-cable.png">
</p>

In late 2018 I purchased 2 WD Easystores from Best Buy and 2 8TB Seagate SMR shingled drives from Amazon and so far they perform identically to their more expensive brethren. You have nothing to fear here except the lack of warranty - but for the price I'll take it.

