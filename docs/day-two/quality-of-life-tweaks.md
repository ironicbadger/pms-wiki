# Quality of Life Tweaks

This page documents lots of little things that don't really need their own page but when implemented will improve your quality of life whilst administering the system.

## Bash Aliases

Bash aliases enable complex commands to be shortned to a few characters. For example `docker-compose -f ~/docker-compose.yml up -d` can be shortned to `dcp up -d` with a the following alias:

```bash
alias dcp='docker-compose -f ~/docker-compose.yml '
```
### Making aliases persistent

Aliases created using the `alias` command in the terminal will only be available for the current session. To make an alias persist across sessions it must be added the shell's initialization file. Here are some examples for popular shells:

 - Bash: `~/.bashrc`, this is typically the default shell.
 - ZSH: `~/.zshrc`
 - Fish: `~/.config/fish/config.fish`

For both Bash and ZSH simply add the desired aliases to the end of the file and reload the file using `. ~/.bashrc` or `. ~/.zshrc`.

Fish is a bit different, the simplest way to save an alias in fish it to add the `-s` or `--save` option to the alias command in the terminal, this will add the alias in the correct format to the `config.fish` file. For example: `alias -s dcp='docker-compose -f ~/docker-compose.yml '`
 
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
