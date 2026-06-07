#!/bin/sh
set -eu

force=0

for arg in "$@"; do
    case "$arg" in
        -f|--force)
            force=1
            ;;
        -h|--help)
            echo "Usage: install_mergerfs.sh [--force|-f]"
            exit 0
            ;;
        *)
            echo "Unknown argument: $arg"
            echo "Usage: install_mergerfs.sh [--force|-f]"
            exit 2
            ;;
    esac
done

cat <<'EOF'
 ____  __  __ ____
|  _ \|  \/  / ___|
| |_) | |\/| \___ \
|  __/| |  | |___) |
|_|   |_|  |_|____/

Perfect Media Server
EOF

echo
echo "This script downloads and installs the latest mergerfs release from GitHub."
echo

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    green="$(printf '\033[32m')"
    red="$(printf '\033[31m')"
    reset="$(printf '\033[0m')"
else
    green=""
    red=""
    reset=""
fi

version_status() {
    current_version="$1"
    latest_version="$2"

    if [ -z "$current_version" ]; then
        printf "%snot installed%s" "$red" "$reset"
    elif dpkg --compare-versions "$current_version" eq "$latest_version"; then
        printf "%sup to date%s" "$green" "$reset"
    elif dpkg --compare-versions "$current_version" lt "$latest_version"; then
        printf "%sbehind%s" "$red" "$reset"
    else
        printf "%snewer installed%s" "$green" "$reset"
    fi
}

for command in curl dpkg dpkg-deb apt; do
    if ! command -v "$command" >/dev/null 2>&1; then
        echo "Required command not found: $command"
        exit 1
    fi
done

if [ "$(id -u)" -ne 0 ] && ! command -v sudo >/dev/null 2>&1; then
    echo "This script needs root privileges or sudo."
    exit 1
fi

sudo_cmd=""
if [ "$(id -u)" -ne 0 ]; then
    sudo_cmd="sudo"
fi

os_release="$(. /etc/os-release && echo "${VERSION_CODENAME:-}")"
arch="$(dpkg --print-architecture)"

if [ -z "$os_release" ]; then
    echo "Could not determine OS release codename."
    exit 1
fi

tmpdir="$(mktemp -d)"
chmod 755 "$tmpdir"
trap 'rm -rf "$tmpdir"' EXIT

deb_url="$(curl -fsSL https://api.github.com/repos/trapexit/mergerfs/releases/latest \
    | grep "browser_download_url.*${os_release}_${arch}.deb\"" \
    | cut -d '"' -f 4 \
    | head -n1)"

if [ -z "$deb_url" ]; then
    echo "No mergerfs .deb found for ${os_release} on ${arch}."
    exit 1
fi

deb_file="$tmpdir/$(basename "$deb_url")"
curl -fsSL "$deb_url" -o "$deb_file"

latest_version="$(dpkg-deb -f "$deb_file" Version)"
installed_version="$(dpkg-query -W -f='${Version}' mergerfs 2>/dev/null || true)"
status="$(version_status "$installed_version" "$latest_version")"

echo
printf "%-14s %-29s %-25s %s\n" "Package" "Currently installed version" "Latest release (GitHub)" "Status"
printf "%-14s %-29s %-25s %s\n" "-------" "---------------------------" "-----------------------" "------"
printf "%-14s %-29s %-25s %s\n" "mergerfs" "${installed_version:-not installed}" "$latest_version" "$status"
echo

if [ "$installed_version" = "$latest_version" ]; then
    echo "mergerfs is already up to date."
    exit 0
fi

if [ "$force" -ne 1 ]; then
    if [ ! -r /dev/tty ]; then
        echo "Refusing to run without --force because no interactive terminal is available."
        exit 1
    fi

    printf "Install or upgrade mergerfs to %s? [y/N] " "$latest_version" > /dev/tty
    read -r answer < /dev/tty

    case "$answer" in
        y|Y|yes|YES)
            ;;
        *)
            echo "Aborted."
            exit 0
            ;;
    esac
fi

$sudo_cmd apt install -y "$deb_file"
