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

if [ "$force" -ne 1 ]; then
    if [ ! -r /dev/tty ]; then
        echo "Refusing to run without --force because no interactive terminal is available."
        exit 1
    fi

    printf "Are you sure you want to proceed? [y/N] " > /dev/tty
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
curl -fL "$deb_url" -o "$deb_file"

latest_version="$(dpkg-deb -f "$deb_file" Version)"
installed_version="$(dpkg-query -W -f='${Version}' mergerfs 2>/dev/null || true)"

if [ "$installed_version" = "$latest_version" ]; then
    echo "mergerfs ${installed_version} is already installed."
    exit 0
fi

$sudo_cmd apt install -y "$deb_file"
