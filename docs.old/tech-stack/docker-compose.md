# docker-compose

Around the time of the 2017 PMS guide I made the switch to `docker-compose` and it has been happily serving my container lifecycle needs ever since. Here's an screen recording example of updating the containers on the DigitalOcean droplet I use to run my personal blog.

<p align="center">
<iframe width="740" height="415" src="https://www.youtube.com/embed/K2QCVMXZVYM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>


## What is docker-compose?

Compose[^1] is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

## How do I use docker-compose?

Here is an example `docker-compose.yaml` snippet for [Librespeed](https://github.com/librespeed/speedtest), a self-hosted speed test app.

```yaml
---
version: "2"
services:
  librespeed:
    image: linuxserver/librespeed
    container_name: librespeed
    ports:
      - 8008:80
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=America/New_York
      - MODE=standalone
      - TELEMETRY=true
      - PASSWORD=badger1
```

YAML[^2] stands for Yet Another Markup Language and for correct parsing of these files careful attention to indentations made up of spaces are key. The specific number of spaces in the indentation is unimportant as long as parallel elements have the same left justification and the hierarchically nested elements are indented further. 

In short, make sure everything lines up vertically and you'll be OK. Use an editor which highlights spaces for bonus points. VSCode has some nice syntax plug-ins and YAML is one of them.

To create the container defined above copy and paste the above into a file placed at `~/docker-compose.yaml`, run `docker-compose up -d` and watch. When the output has finished updating, your Librespeed container will be accessible at `serverip:8008`. Try it out!

## Quality of life tweaks

Bash aliases make dealing with docker-compose much easier. Being a good sysadmin is about being fundamentally lazy and finding ways to reduce the amount of work you have to do. This is where bash aliases come in. There is dedicated section about bash aliases under *Day Two -> [Quality of Life Tweaks](../day-two/quality-of-life-tweaks.md#bash-aliases)*. Here are some primarily related to docker-compose.

```bash
# /etc/bash_aliases
# Aliases in this file are available to all users
# To install for one user place in ~/.bash_aliases

# Tail last 50 lines of docker logs
alias dtail='docker logs -tf --tail='50' '

# Shorthand, customise docker-compose.yaml location as needed
alias dcp='docker-compose -f ~/docker-compose.yaml '

# Remove unused images (useful after an upgrade)
alias dprune='docker image prune'

# Remove unused images, unused networks *and data* (use with care)
alias dprunesys='docker system prune --all'
```


[^1]: [Docker - docker-compose](https://docs.docker.com/compose/)
[^2]: [YAML.org - Spec](https://yaml.org/spec/)
