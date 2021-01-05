# Quality of Life Tweaks

This page documents lots of little things that don't really need their own page but when implemented will improve your quality of life whilst administering the system.

## Bash Aliases

Bash aliases enable complex commands to be shortned to a few characters. For example `docker-compose -f ~/docker-compose.yml up -d` can be shortned to `dcp up -d` with a the following alias:

```bash
alias dcp='docker-compose -f ~/docker-compose.yml '
```

!!! info
    If you have a useful alias you think would benefit PMS users please submit a PR via GitHub for inclusion in this site following the format below. One alias or a group of related aliases showing example output.

### Alias - Get container IPs

* Credit: @quietsy - [Self-Hosted Discord](https://discord.gg/efhGsp75dx) server

This alias prints the IP, network and listening ports for each container.

```
alias dcips=$'docker inspect -f \'{{.Name}}-{{range  $k, $v := .NetworkSettings.Networks}}{{$k}}-{{.IPAddress}} {{end}}-{{range $k, $v := .NetworkSettings.Ports}}{{ if not $v }}{{$k}} {{end}}{{end}} -{{range $k, $v := .NetworkSettings.Ports}}{{ if $v }}{{$k}} => {{range . }}{{ .HostIp}}:{{.HostPort}}{{end}}{{end}} {{end}}\' $(docker ps -aq) | column -t -s-'

$ alex@cartman:~$ dcips
/tautulli      backend  172.18.0.3    8181/tcp
/lychee        backend  172.18.0.16   80/tcp
/tr            internet  172.18.0.4                      443/tcp => 0.0.0.0:443 80/tcp => 0.0.0.0:80 8080/tcp => 0.0.0.0:8080
/chowdown      backend  172.18.0.24                     4000/tcp => 0.0.0.0:4000
```

### Alias - Get top style view of containers

this alias function, will give you a top style view of your containers
```
dctop() {
  docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}  {{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"
}

$ ctrl+alt@w dctop

CONTAINER      NAME                   CPU %  MEM %   NET I/O           BLOCK I/O
XXXXXXXXXXXX   XXXX                   0.11%  1.37%   38.2kB / 158B     183MB / 57.3kB
XXXXXXXXXXXX   XXXXXXXX               0.07%  2.83%   305kB / 47.8kB    285MB / 26.6MB
XXXXXXXXXXXX   XXXXXX                 2.35%  2.09%   96.2kB / 30.1kB   188MB / 3.65MB
XXXXXXXXXXXX   XXXXXXXXXXXXXXXXXXXXX  0.00%  0.95%   38.1kB / 0B       93MB / 0B
XXXXXXXXXXXX   XXXXXXX                0.08%  1.87%   181kB / 1.3MB     165MB / 57.3kB
XXXXXXXXXXXX   XXXXXXXXXXXXXXXXXXXX   0.24%  0.42%   1.26MB / 1.94MB   40.9MB / 1.7MB
XXXXXXXXXXXX   XXXXXX                 2.18%  2.63%   1.4MB / 57.7kB    148MB / 5.34MB
XXXXXXXXXXXX   XXXXXXXX               0.17%  1.19%   44.2kB / 21.3kB   62.4MB / 1.08MB
XXXXXXXXXXXX   XXXXXXXXX              0.00%  0.25%   437kB / 6.3MB     71.7MB / 1.01MB
XXXXXXXXXXXX   XXXXXXX                0.00%  0.23%   73.8kB / 11.3kB   20.6MB / 41kB
XXXXXXXXXXXX   XXXXXXXXXX             0.00%  0.15%   0B / 0B           24.7MB / 0B
XXXXXXXXXXXX   XXXXXXXXXXX            0.04%  1.63%   2MB / 1.37MB      175MB / 172kB
```
