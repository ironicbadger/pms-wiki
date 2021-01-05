# WireGuard

!!! info
    This page is a work in progress.

This page will cover two WireGuard architectures. The first is running WireGuard within your LAN and connecting to that server from a remote endpoint by punching a hole in your firewall with port forwarding. The second will require use of a satellite node running on a VPS to bounce connections through - this is the more secure and recommended route to take.

## WireGuard Server on your LAN

* Todo

## WireGuard Server on a VPS

This section will talk about setting up a VPS and then running a client on your network to setup the connection to the VPS and allow the vpn to work without a firewall opening. 

The first step is to decide on a virtual host provider and create a server. When you decide on a provider and create a host. Install Wireguard using the instructions provided on the [Wireguards Documentation](https://www.wireguard.com/install/)

### Server Configuration Setup:
First create a folder to contain all the details of our configuration.
```shell
mkdir wireguard
cd wireguard
```

Now you must create the keys you have to options on how many keys you need to make. The simplest allows for just two keys but wireguard also allows you to provide a preshared key as well. For this configuration we will work with the preshared key but if you do not want to you can remove those files from the configuration.

```shell
wg genkey | tee cloud_key.priv | wg pubkey > cloud_key.pub
wg genkey | tee client_1_key.priv | wg pubkey > client_1_key.pub
wg genpsk > client_1_cloud_preshared_key.psk
```

```shell
vim /etc/wireguard/wg0.conf
```

When you create the file you will copy the following configuration:
```
[Interface]
# Cloud
Address = 192.168.1.1/24
ListenPort = 51902
PrivateKey = << Private Key - cloud_key.priv >>

PostUp = iptables -A FORWARD -i %i -j ACCEPT ; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT ; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
# Client 1
PublicKey = << Public Key - client_1_key.pub >>
PresharedKey = << Preshared Key - client_1_cloud_preshared_key.psk >>
AllowedIPs = 192.168.1.2/32,10.0.0.0/16
Endpoint = << Client 1 DDNS >>:51902

[Peer]
# Client 2
PublicKey = << Public Key - client_2_key.pub >>
PresharedKey = << Preshared Key - client_2_cloud_preshared_key.psk >>
AllowedIPs = 192.168.1.3/32
Endpoint = << Client 2 DDNS >>:51902

```

Lets talk about the information provided above. First we will talk about the Interface Section:

#### Interface Configuration Definitions
| Config Name | Required | Description | example |  
| ----------- | -------- | ----------- | ------- |
| Comment | False | A human readable name for the host this will be run on.  | # cloud |
| Address | True | This is the IP and the subnet for the Wireguard VPN. When choosing a subnet make sure this subnet is different then the LAN of the compueter you are running this on. | 192.168.1.1/24 |
| Listen Port | True| The Port to have teh wireguard service listen on.  | 51902 |
| Private Key | True | This is the value in the file: client_1_cloud_preshared_key.psk |
| PostUp | False | This is a list of commands to run after the wireguard VPN is stood up. The commands here are if you want to expose the LAN of the server to the Wireguard VPN. | iptables -A FORWARD -i %i -j ACCEPT ; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
|
| PostDown | False | This is a list of commands to run after the wireguard VPN is taken down. The commands here reverses the commands ran in the postUP command. | 192.168.1.1/24 |

Now lets talk about the Peer configuration. The peer is the interfaces that will talk directly to this server. 

#### Peer Configuration Definitions
| Config Name | Required | Description | example |  
| ----------- | -------- | ----------- | ------- |
| Comment | False | A human readable name for the host this will be run on.  | # cloud |
| PublicKey | True |  | This is the value in the file: client_1_key.pub |
| PresharedKey | False |  | This is the value in the file: client_1_cloud_preshared_key.psk |
| AllowedIPs | True | This is a comma separated list of IPs that are allowed to go through the wireguard VPN, for each peer you setup. If you would like to have multiple ranges you can add more like this: 192.168.1.2/32,10.0.0.0/16 | 192.168.1.2/32 |
| Endpoint | False | This is the URL to that the wireguard program will reach out to. If it is behind a NAT then it will not be able to reach the endpoint unless you open the firewall to allow the connection through to your computer. This can be an IP or a FQDN. | wg.example.com:51902 |


In the file above I have included the configuration for a second peer as an example on how to add multiple peers. 
The next thing to do is to enable IP forwarding, to do this you need to run the following command:

```shell
sysctl -w net.ipv4.ip_forward=1
```

The final step is to start the server, and set it up to start automatically. 

```shell
wg-quick up wg0
sudo systemctl enable wg-quick@wg0
```

### Setup the Client to access the VPN
```
[Interface]
# Client 1
PrivateKey = << Private Key - client_1_key.priv >>
ListenPort = 51902
Address = 192.168.1.2/24

[Peer]
# Cloud
PublicKey = << Public Key - cloud_key.pub >>
PreSharedKey = << Preshared Key - client_1_cloud_preshared_key.psk >>
Endpoint = wireguard.example.com:51902
AllowedIPs = 192.168.1.0/24
PersistentKeepalive = 25
```

The interface setup is the same as what we did on the server. Except we now need to use the client's private key.

#### Peer Configuration Definitions
| Config Name | Required | Description | example |  
| ----------- | -------- | ----------- | ------- |
| Comment | False | A human readable name for the host this will be run on.  | # cloud |
| PublicKey | True |  | This is the value in the file: client_1_key.pub |
| PresharedKey | False |  | This is the value in the file: client_1_cloud_preshared_key.psk |
| AllowedIPs | True | This is a comma separated list of IPs that are allowed to go through the wireguard VPN, for each peer you setup. If you would like to have multiple ranges you can add more like this: 192.168.1.2/32,10.0.0.0/16 | 192.168.1.2/32 |
| Endpoint | True | This is the URL to that the wireguard program will reach out to. If it is behind a NAT then it will not be able to reach the endpoint unless you open the firewall to allow the connection through to your computer. This can be an IP or a FQDN. | wg.example.com:51902 |

Now lets look at the Peer config for the connection to the cloud. The difference between the Server configuration and
the client configuration is minor. The first is the endpoint is required, if you use a url instead of an IP address you
need to be aware that if the IP changes you need to restart the wireguard connection, on the client. This is because the
URL is converted to an IP when it is initiated. The final difference is the addition of the configuration
PersistentKeepAlive. This is what allows us to use this VPN without any firewall openings. This sends data to the server
to keep the connection alive. Without this wireguard is naturally a quiet connection, and only sends traffic when you do
it intentionally.

### Setup the Client to share its network
```
[Interface]
# Client 1
PrivateKey = << Private Key - client_1_key.priv >>
ListenPort = 51902
Address = 192.168.1.2/24

PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE


[Peer]
# Cloud
PublicKey = << Public Key - cloud_key.pub >>
PreSharedKey = << Preshared Key - client_1_cloud_preshared_key.psk >>
Endpoint = wireguard.example.com:51902
AllowedIPs = 192.168.1.0/24
PersistentKeepalive = 25
```
The file looks very similar to the configuration file in the section "Setup the Client to access the VPN". There are two main differences, the first is we need to add the configuration PostUp and PostDown. This configuration as defined below shares the netowrk on the endpoint it is ran on. The second change is we need to add the IP ranges for the other networks. 

#### Interface Configuration Definitions
| Config Name | Required | Description | example |  
| ----------- | -------- | ----------- | ------- |
| PostUp | False | This is a list of commands to run after the wireguard VPN is stood up. The commands here are if you want to expose the LAN of the server to the Wireguard VPN. | iptables -A FORWARD -i %i -j ACCEPT ; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
|
| PostDown | False | This is a list of commands to run after the wireguard VPN is taken down. The commands here reverses the commands ran in the postUP command. | 192.168.1.1/24 |

#### Peer Configuration Definitions
| Config Name | Required | Description | example |  
| ----------- | -------- | ----------- | ------- |
| AllowedIPs | True | This is a comma separated list of IPs that are allowed to go through the wireguard VPN, for each peer you setup. | 192.168.1.2/32,10.0.0.0/16 |

# Test the connection.
To test the connection you first can test the connection within the wireguard configuration, from host client 1 send a ping like the following. 

```shell
ping 192.168.1.1
```

If all is working the response should look like this:
```
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=26.8 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=26.7 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=28.1 ms
--- 192.168.1.1 ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5009ms
rtt min/avg/max/mdev = 26.745/28.130/31.222/1.498 ms
```

