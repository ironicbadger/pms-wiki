# Overview of Perfect Media Server

The aim of this site is to share knowledge and information about building a media server. To find what you're looking for use the search function - it can be invoked by pressing `/` and typing your query.

## What is Perfect Media Server?

PMS is a 100% open-source collection of technologies enabling you to build your own media server from scratch and runs on Linux.

Media servers generally run 24/7, needs lots of hard drives and often run apps to compliment the experience such as Plex, Nextcloud and so on - see the [top 10 self-hosted app list](../day-two/top10apps.md) for inspiration there. PMS sets out to fulfil the following requirements:

* Act as a NAS type device serving files across the network
* Support the primary use-case of "write once - read many" for media files
* Support hard drives of differing / mismatched sizes
* Enable incremental upgrading of hard drives in batches as small as one
* Each drive should have a separately readable filesystem with no striping of data
* Pool multiple hard drives under a single mount point for reads and writes
* Spin up only the drive(s) in use
* Provide fault tolerance to protect against (inevitable) hard drive failure
* Checksum files to guard against bitrot
* Saturate a gigabit LAN connection
* Run multiple applications at once using containers

PMS requires a bit more elbow grease to setup compared with other solutions but you are in complete control of every aspect of your system and once it's done it will just keep on going for years to come. 

On top of that, the software used is all open source which means you'll never be at the mercy of a companies decision to change tack leaving you locked in to a legacy solution. Furthermore there are no license fees to pay and perhaps best of all, there’s a comprehensive guide on how you can set this up yourself!!

## Where do I start?

You've already found your way to this site so you're in a good spot. Organising so much information has been a labour of love for several months but a good place to start would be familiarising yourself with the primary tech stack components before moving onto the installation section.

We cover some hardware topics here as well but you might want to go and check out my friends over at [serverbuilds.net](https://serverbuilds.net) for some interesting, low cost ideas in that department.

Beyond that go ahead and make extensive use of the search feature which can be invoked with `/`, just like in Vim.

You can find me on the [Self-Hosted podcast Discord server](https://discord.gg/efhGsp75dx) or [Twitter](https://twitter.com/ironicbadger) where I'm @IronicBadger if you have questions, concerns or feedback about the site. Please also consider contributing [via PR](https://github.com/IronicBadger/pms-wiki/) if you find something that needs fixing.

## Why did you write this??

This project was born out of a period in my life between 2011 and 2016 where I discovered network attached storage and lost some important data to a cursed 1.5tb Seagate hard drive. I took a fairly typical journey down the rabbit hole starting out with a Drobo, then a Synology, then unRAID before finally deciding to go it alone and piece together my own solution on top of Linux.

During this period I discovered Linux, the world of open-source and everything that enabled. Open-source has fundamentally changed my life for the better and I now work for Red Hat helping to further that mission. 

PMS is my own personal project to give back to the community knowledge that so many others helped me learn - life changing skills and knowledge about building and managing my own servers and infrastructure. Thank you if you were one of those who helped me along the way - this site is for you.
##
- - -

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

*[PMS]: Perfect Media Server
*[PR]: Pull Request
