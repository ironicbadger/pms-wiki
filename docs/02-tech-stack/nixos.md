---
description: Take the blue pill and enter declarative server nirvana.
---

# NixOS

![nixos](../images/logos/nixos-logo.png)

NixOS is quite different from almost any other Linux distribution you've ever used. It is a Linux distribution built on top of the Nix[^1] package manager which uses a *declarative model* for package and configuration management[^2].

This is a fancy way of saying "I declare I want my system to look like this" via a `configuration.nix` file and having the Nix tooling go and figure out how to turn that config file into a functional system. We'll get more into more of a discussion about Flakes[^4] shortly but first, let's explore what attracted me to NixOS in the first place, simplicity.

What if I told you that you could configure your entire system in one single file? What if that file could configure installed packages, file shares, users, networking and allow the same sort of modularity that tools like Ansible do but at a fraction of the cognitive investment? 

That is the promise of NixOS.

## Take the blue pill

There is a lot to like about Nix (the package manager) and NixOS (the OS) but if you aren't careful, you will drown in the complexity on offer. This article is deliberately sparse of the deeply inner technical workings of the Nix ecosystem in an attempt to make it more approachable.

## The `configuration.nix` file

Example snippets from `/etc/nixos/configuration.nix`. The full example file can be found [here](nixos/configuration.nix.md){:target="_blank"}.

!!! warning
    Make sure to read the [Flakes](#flakes) and [To Flake, or not to Flake](#to-flake-or-not-to-flake) sections of this article before proceeding.

### User Management

Creating a user named `alex` is easy, as is configuring the group membership of that user. Typically this is would require something like `usermod -aG docker alex` or a specific Ansible playbook task.

``` nix
users.users.alex = {
  isNormalUser = true;
  extraGroups = [ "wheel" "docker" ];
};
```

### Packages

With a "normal" Linux distro, if you wanted to install a package it's as easy as typing `apt install htop`. You can operate in this fashion on NixOS but it isn't recommended. The next time you build your system any changes you made manually will be overridden by the "declared state" in `configuration.nix`. This is by design. And it's a good thing.

``` nix
environment.systemPackages = with pkgs; [
  htop
  vim
  hollywood
];
```

### Networking

Want to specify a static IP address for your system? It's just a few lines.

``` nix
networking = {
  firewall.enable = false;
  hostName = "testnix";
  interfaces = {
    enp1s0 = {
      useDHCP = false;
      ipv4.addresses = [ {
        address = "10.42.0.50";
        prefixLength = 20;
      } ];
    };
  };
  defaultGateway = "10.42.0.254";
  nameservers = [ "10.42.0.253" ];
};
```

### Virtualisation

How does one install docker "the Nix way?" Nix is smart. It knows by us asking to enable docker that we probably want the docker package installing and exposes us some other niceties like `autoPrune`. NOTE: This is also enables and starts the docker service too - it's up to you to add your user to the docker group though (see above).

In a normal install we'd have to get pretty far down into the weeds to configure things like that, with Nix its just a few lines.

``` nix
virtualisation = {
  docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
};
```

### Service Management

The equivalent of `systemctl enable sshd` is straightforward.

``` nix
services.openssh = {
  enable = true;
  settings.PasswordAuthentication = false;
  settings.PermitRootLogin = "yes";
};
services.tailscale.enable = true;
```

### Enable ZFS

This one is really hard.

``` nix
boot.supportedFilesystems = [ "zfs" ];
boot.zfs.extraPools = [ "tank" ];
services.zfs.autoScrub.enable = true;
```

Yup, that's it! Really.

## Flakes

One of the biggest problems NixOS has right now is that it's in the middle of a transition and everything you just read above is *probably* going to be replaced by a much more complicated, and much less well documented configuration paradigm known as *Flakes*[^4]. Flakes have proven to be a controversial [^5] [^6] feature in the Nix community however, they appear to be the future of the ecosystem.

So if the beautiful single-file simplicity isn't the future and Flakes are, then why even bother with Nix? This is a tough question to answer. The learning curve for Flakes, if you're trying to write your own from scratch as non-developer, is near vertical. Despite this, I persevered with them over the course a few weeks. And ended up with a single Flake that can deploy a common set of packages and other user goodies, like shell integrations across Linux *and* MacOS. Don't knock them until you've experienced them!

Remember how Nix is a package manager? Well, that means we can use Nix and a related tool called [Home Manager](https://github.com/nix-community/home-manager) to manage these configurations, declaratively, across multiple architectures and OSs. If you don't think that's cool, then you probably have your answer about whether NixOS is for you or not!

``` nix title='Excerpt from <a href="https://github.com/ironicbadger/nix-testing/blob/main/flake.nix" target="_blank">github.com/ironicbadger/nix-testing/flake.nix</a> that shows configuring macOS alongside nixOS in the same file.' 
{
  darwinConfigurations = {
    personal-laptop = darwinSystem "aarch64-darwin" "slartibartfast" "alex";
    work-laptop = darwinSystem "aarch64-darwin" "magrathea" "alex";
  };

  nixosConfigurations = {
    media-server = nixosSystem "x86_64-linux" "morpheus" "alex";
  };
};
```

## To Flake, or not to Flake?

This is not an easy question to answer. If absolute dependency pinning and reproducibility at all costs is your goal then they are for you. Likewise if you're a software developer and your mind works in code - you'll likely love them.

However, for the rest of us mere mortals the learning curve for flake adoption is almost vertical. And it doesn't really start to level out for quite a long time. For most people, most of the time - and certainly those of you who are new to Linux and building your own systems - it is likely too much. The single file based `configuration.nix` paradigm is so beautiful, so elegant, and simple to understand that if I were building a PMS from scratch today, it's where I would start.

PMS has historically been based around the Debian / Ubuntu ecosystem for many years. In no small part to the ZFS courage shown by Canonical. But Nix gives us almost everything these distros do, and in such an amazingly simple package. The biggest downside? It's different. You wil have to adjust your way of thinking. But once you do, there is little doubt that Nix - or at least fully declarative systems - are the only way to roll.


[^1]: [GitHub - Nix, the purely functional package manager](https://github.com/NixOS/nix)
[^2]: [Nixos.org - How Nix works](https://nixos.org/guides/how-nix-works.html)
[^4]: [Nixos.org - Flakes](https://nixos.wiki/wiki/Flakes)
[^5]: [discourse.nixos.org - Why are Flakes still experimental?](https://discourse.nixos.org/t/why-are-flakes-still-experimental/29317/11)
[^6]: [GitHub - nixos/rfcs #136](https://github.com/NixOS/rfcs/pull/136)