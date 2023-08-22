# NixOS

![nixos](../images/logos/nixos-logo.png)

!!! info
    August 21st 2023 - This page is not finished yet.

NixOS is quite different from almost any other Linux distribution you've ever used. It is a Linux distribution built on top of the Nix[^1] package manager which uses a *declarative model* for package and configuration management[^2].

The declarative model has its roots in software development[^3]. This is a fancy way of saying "I declare I want my system to look like this" via a `configuration.nix` file and having the Nix tooling go and figure out how to turn that config file into a functional system. We'll get more into more of a discussion about Flakes[^4] shortly but first, let's explore what NixOS does well for readers of PMS.

What if I told you that you could configure your entire system in one single file? What if that file could configure installed packages, file shares, users, networking and allow the same sort of modularity that tools like Ansible do but at a fraction of the cognitive investment? 

That is the promise of NixOS.

## The Rabbit Hole

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

Remember how Nix is a package manager? Well, that means we can use Nix and a related tool called [Home Manager](https://github.com/nix-community/home-manager) to manage this configurations, declaratively, across multiple architectures and OSs. If you don't think that's cool, then you probably have your answer about whether NixOS is for you or not!

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




[^1]: [GitHub - Nix, the purely functional package manager](https://github.com/NixOS/nix)
[^2]: [Nixos.org - How Nix works](https://nixos.org/guides/how-nix-works.html)
[^3]: [Wikipedia - Declarative Programming](https://en.wikipedia.org/wiki/Declarative_programming)
[^4]: [Nixos.org - Flakes](https://nixos.wiki/wiki/Flakes)
[^5]: [discourse.nixos.org - Why are Flakes still experimental?](https://discourse.nixos.org/t/why-are-flakes-still-experimental/29317/11)
[^6]: [GitHub - nixos/rfcs #136](https://github.com/NixOS/rfcs/pull/136)