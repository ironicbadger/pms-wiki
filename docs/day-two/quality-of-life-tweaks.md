# Quality of Life Tweaks

This page documents lots of little things that don't really need their own page but when implemented will improve your quality of life whilst administering the system.

## Bash Aliases

Bash aliases enable complex commands to be shortned to a few characters. For example `docker-compose -f ~/docker-compose.yml up -d` can be shortned to `dcp up -d` with a the following alias:

```bash
alias dcp='docker-compose -f ~/docker-compose.yml '
```
