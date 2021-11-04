# Docker

Back in 2016 when I wrote the [original](https://blog.linuxserver.io/2016/02/02/the-perfect-media-server-2016/) PMS article Docker was a fairly new kid on the block. Fast forward 5 years and containerisation has cemented itself as a major force in the industry.

For those looking to build a media server, containers offer a uniquely brilliant way to run applications. They divorce the running application from its data whilst making managing their persistent data and configuration simple.

![docker-log](../images/docker-logo-horizontal.png)

## Why should I use containers?

We'll come onto what a container is shortly but first let's discuss why you might consider using them.

My lightbulb moment with docker came a few years ago after I'd reinstalled my server OS. I'd got everything just the way I liked it, all the apps were working great but an update borked something and I had to reload. However, this time, I was using docker for my applications, stored their data in volumes[^1] and kept a text file with each command I'd use to create the containers (this was pre docker-compose).

What normally followed reinstallation was a lengthy, often multi-day, process of getting things back to where they were. This time though, things were different. I copied each `docker run` command and I was back up and running within 10 *minutes*, I was done. That was it, the game changed that day.

This was because the configuration data for the applications was stored in a separate location via a volume[^1] bind mount. Backing up configuration was nothing new but that this happened by design meant I'd taken a leap forward in deployment reliability and repeatability.

Traditionally when an application is installed onto a system it has access to the entire thing. Permissions help to some degree but a container has zero access to the system around it unless explicitly granted. This level of granular control is very useful when running multiple versions of the same application or if you don't quite trust it will do what it said on the tin.

Beyond the fact that separating the application runtime from its configuration makes the above scenario possible containers also provide a number of other benefits. These range from portability to standardisation to security to employability.

## What is a container?

A container is an application in a box. A few years ago, the Linux kernel added some features called namespaces and cgroups which enable isolating processes from each other. Therefore, in essence, a container is a process isolated in memory by the kernel.

!!! tip
    [This](https://archive.fosdem.org/2016/schedule/event/namespaces_and_cgroups/) talk by James Bottomley at FOSDEM 2016 was pivotal in my understanding of containers. He explains what cgroups and namespaces are in a way that is easy to understand and I highly suggest watching the recording of his talk linked [here](https://archive.fosdem.org/2016/schedule/event/namespaces_and_cgroups/).

What this means for users is that dependency and resource clashes are a thing of the past. Need two slightly different versions of Java for two applications? No problem!

More than this, containers are more secure. They employ the principal of minimum viable permissions and unless you permit access into them, you are guaranteed by virtue of the kernel technology underneath that noone else can either. 

### My first container

For example, nginx is a popular web server - in fact it is serving this website to your eyeballs and is running in a container! Web servers use ports to listen for traffic, commonly port 80 or 443.

    docker run -p 80:80 nginx

On a host with docker running, this command will create an nginx container and permit you access to port 80 where the web server is running by visiting `http://system-ip` in your browser.

!!! info
    To stop a running container that you are attached to press ++ctrl+c++.

Try running the same command again but remove `-p 80:80`. Notice how by removing the port option you are no longer permitted to access that container - it's kind of like port forwarding but it works for every container individually.

### Running multiple versions of the same app

Suppose we wanted to run two webservers like so:

    docker run --name nginx1 -p 80:80 nginx
    docker run --name nginx2 -p 81:80 nginx

Notice that the second container uses port 81. This is because the command `-p 81:80` is actually mapping port 80 from inside the container to port 81 on the host. Ports mapped to the host must be unique but nginx can run on port 80 inside each container because each one is its own isolated environment.

## docker-compose

See [docker-compose](docker-compose.md).

## Where do I get containers from?

Docker were first to market and hijacked the root namespace when you execute a `docker run` command. As such, [Docker Hub](https://hub.docker.com/) is the primary source for containers but Docker Inc. has been struggling to monetize the technology from the very beginning and the [cracks](https://www.docker.com/blog/what-you-need-to-know-about-upcoming-docker-hub-rate-limiting/) are starting to show.

Some other notable registries include, but are not limited to:

* [Quay.io](https://quay.io/)
* [GitHub Container Registry](https://github.com/features/packages)

I might be biased due to my prior involvement with the project but [LinuxServer.io](https://linuxserver.io) make the largest collection of media server type containers on the internet. At the time of writing their containers have seen over 14 billion pulls and you can find a full list of the available apps packaged by the team [here](https://fleet.linuxserver.io/).

## How do I pick one container over another?

It's a common question I see, and a valid one.

<div class="reddit-embed" data-embed-media="www.redditmedia.com" data-embed-parent="false" data-embed-live="false" data-embed-uuid="ab15371c-d825-4747-ab1b-1451c2d8b65e" data-embed-created="2020-12-28T01:30:18.316Z"><a href="https://www.reddit.com/r/selfhosted/comments/kece3p/intels_quick_sync_is_a_total_game_changer_im_a/gg4oerh/">Comment</a> from discussion <a href="https://www.reddit.com/r/selfhosted/comments/kece3p/intels_quick_sync_is_a_total_game_changer_im_a/">Intel&#x27;s Quick Sync is a total game changer - I&#x27;m a little late to the party but here&#x27;s a post on how I set it up with Proxmox, Plex and Blue Iris using Intel GVT-g (virtual GPUs)</a>.</div><script async src="https://www.redditstatic.com/comment-embed.js"></script>

The first place I always check is LinuxServer's [Fleet](https://fleet.linuxserver.io/) list of images - if an LSIO image exists, job done. I'll always pick LSIO images first because of:

* Easy user mappings via `PGID` and `PUID`
* Regular security and application updates
* A fully open and auditable [build pipeline](https://ci.linuxserver.io)
* The documentation is great
* I wrote a few of them

!!! info
    If LSIO make a container as well as the upstream project then you might want to default to the upstream image. 
    
    *But*, almost all LSIO images support multiarch and some offer features that the officially provided containers don't such as hardware transcoding for Plex - I run the `linuxserver/plex` image for integration with Intel QuickSync.

Next, I'll take a look at Docker Hub. If there are multiple images doing the same thing I'll look at the number of downloads - generally more is better but not always. I'll try and find the Dockerfile for the container in question - usually this is available on the Docker Hub page but not always (I'll avoid Dockerfile-less containers as I have little clue what they're up to).

After those two resources are exhausted I might try and have a go at writing a Dockerfile myself. If the app is uncooperative or poorly written I'll probably give up and try to find a different app instead - there's always another.

For an incredible list of inspiration, check out [awesome-selfhosted](https://github.com/awesome-selfhosted/awesome-selfhosted) on GitHub.

## What about podman?

[Podman](https://podman.io) is a daemonless container engine for your Linux system. The project claims that `alias docker=podman` is the hardest part of switching but in my testing podman still has a way to go to match docker in a few areas.

The first is full on compose support. That is defining your stack of containers in a yaml file declaritively and repeatably. The [podman-compose](https://github.com/containers/podman-compose) is working on improving compatibility here but I've not found it to be a reliable, production ready replacement for docker-compose quite yet.

Second are builds. At work the other day I built a container from a Dockerfile with both podman on Fedora and docker on Arch - each of those container images came out at vastly different finished sizes. The podman image was 1.4gb whilst the docker image was less than 350mb.

Third is the community effect. Everyone in the media server space is using docker. It's the kleenex of containers and I don't see that changing anytime soon. Yes both projects tout OCI compatibility but there are some differences under the hood in how the two projects are wired which leads to inconsistencies. There's also a general lack of knowledge amongst those who freely donate their time to help others so it's a bit of a chicken and egg problem this one.

Podman is aimed at a different primary usecase, Kubernetes. This project is definitely one to keep an eye on though so who knows, maybe the 2021 post will proclaim that podman is ready for primetime.

*[OS]: Operating System
*[PMS]: Perfect Media Server
*[LSIO]: LinuxServer.io

[^1]: [Docker Volumes explained](https://docs.docker.com/storage/volumes/)
