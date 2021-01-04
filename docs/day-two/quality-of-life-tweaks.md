# Quality of Life Tweaks

This page documents lots of little things that don't really need their own page but when implemented will improve your quality of life whilst administering the system.

## Bash Aliases

Bash aliases enable complex commands to be shortned to a few characters. For example `docker-compose -f ~/docker-compose.yml up -d` can be shortned to `dcp up -d` with a the following alias:

```bash
alias dcp='docker-compose -f ~/docker-compose.yml '
```

!!! info
    If you have a useful alias you think would benefit PMS users please submit a PR via GitHub for inclusion in this site following the format below. One alias or a group of related aliases showing example output.

### Aliases in fish shell
If fish shell is being used, aliases created using the `alias` command will not persist from one session to the next. In order to save an alias the `-s` or `--save` option must be used, refer to fish shell documentation: [alias - create a function](https://fishshell.com/docs/current/cmds/alias.html). Using the same example as above creating a persistent an alias in Fish looks like this:

```fish
alias -s dcp='docker-compose -f ~/docker-compose.yml '
```

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
