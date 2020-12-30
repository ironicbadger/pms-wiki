# Remote Access

!!! info
    This page is a work in progress.

This page will detail the numerous ways in which it is possible to securely remotely access a PMS system (or any Linux system for that matter).

## Port Forwarding

The oldest, easiest and most well-known way of enabling remote access to your PMS. It's also the least secure. Opening a port in your firewall should be a last resort and honestly, avoided unless absolutely neccessary.

## VPNs

VPNs are common place these days. Many folks use them to pretend to be in a country they are not to avoid geoblocks with streaming services or to connect to their place of work. They can also be used to hide your immediate identity online so are often used to sail the seven seas and should *definitely* be used on any kind of public wifi.

We can use VPNs for more than this though. By using a VPN to secure the traffic passing in and out of our firewall we largely avoid the need to open ports in our firewall which we already established is bad security practice unless absolutely neccessary.

### WireGuard VPN

WireGuard was first merged to the Linux kernel v5.6 in March 2020 [^1]. A relative newcomer to the VPN scene the project took a completely fresh approach to VPNs and aims to be "faster[^2], simpler[^3], leaner" than other VPN technologies. The OpenVPN codebase is approximiately 70,000 lines long[^4] compared just 4,000 with WireGuard.

WireGuard is so crucial to the future of operating a system in this space these days that I've split out the WireGuard setup into its own section [here](../day-two/wireguard.md) 

!!! info
    Editors note on Dec 30 2020: The WireGuard guide will be a WIP but finished soon.

### OpenVPN

* include?

## Mobile

Accessing your server remotely could be crucial to your long term sanity and adoption of PMS. Here is how to manage the system from a mobile device successfully - optionally use [Wireguard](#wireguard) to avoid opening ports in your firewall and still maintain access.

### iOS

* Blink

### Android

* JuiceSSH

[^1]: [WireGuard VPN makes it to 1.0.0 -- and into the next Linux kernel - Jim Salter, Ars Technica](https://arstechnica.com/gadgets/2020/03/WireGuard-vpn-makes-it-to-1-0-0-and-into-the-next-linux-kernel/)
[^2]: [WireGuard Performance](https://www.wireguard.com/performance/)
[^3]: [WireGuard Quickstart](https://www.wireguard.com/quickstart/)
[^4]: [OpenVPN GitHub](https://github.com/OpenVPN/openvpn)