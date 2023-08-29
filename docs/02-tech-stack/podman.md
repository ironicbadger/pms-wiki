# What about podman?

[Podman](https://podman.io) is a daemonless container engine for your Linux system. The project claims that `alias docker=podman` is the hardest part of switching but in my testing podman still has a way to go to match docker in a few areas.

The first is that rootless containers don't really solve a problem real people have outside large enterprise organisations. Running a process as root inside a container is still 100x safer than letting that same process do the same without the sandboxing containers provide. The mapping of non-root users to root users is [well-documented](https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md) but ultimately a perplexingly complicated topic for all but the most seasoned of Linux grey beards. This complexity negatively affects not only the user the process runs as but, of course, the files that user touches via volume mounts. It means that entire container development ethos', such as those employed by LSIO, become unusable and I'd be cutting out a huge swathe of container images available to me if I chose to go this route.

<p align="center">
<figure markdown>
<iframe src="https://player.fireside.fm/v2/dUlrHQih+fp1aR6Lw?theme=dark" width="740" height="200" frameborder="0" scrolling="no"></iframe>
<figcaption>In March 2023, we released a podcast episode on this exact topic. Check it out for a more in-depth discussion.</figcaption>
</figure>
</p>

Second is the community effect. Everyone in the media server space is using docker. It's the kleenex of containers and I don't see that changing anytime soon. Yes both projects tout OCI compatibility but there are some differences under the hood in how the two projects are wired which leads to inconsistencies. There's also a general lack of knowledge amongst those who freely donate their time to help others so it's a bit of a chicken and egg problem this one.

Podman is aimed at a different primary usecase, Kubernetes. It is improving dramatically with each release. Version 4 released in 2022 provided some major steps forward for compose compatibility, overall polish and improvments in many other areas. It's just not at that tipping point yet where it's ready for primetime in a solution like PMS.