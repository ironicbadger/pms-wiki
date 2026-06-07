#!/bin/sh
set -eu

force=0

for arg in "$@"; do
    case "$arg" in
        -f|--force)
            force=1
            ;;
        -h|--help)
            echo "Usage: install_snapraid.sh [--force|-f]"
            exit 0
            ;;
        *)
            echo "Unknown argument: $arg"
            echo "Usage: install_snapraid.sh [--force|-f]"
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
echo "This script downloads and installs the latest SnapRAID and snapraid-daemon releases from GitHub."
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

arch="$(dpkg --print-architecture)"
tmpdir="$(mktemp -d)"
chmod 755 "$tmpdir"
trap 'rm -rf "$tmpdir"' EXIT

snapraid_url="$(curl -fsSL https://api.github.com/repos/amadvance/snapraid/releases/latest \
    | grep "browser_download_url.*_${arch}.deb\"" \
    | cut -d '"' -f 4 \
    | head -n1)"

daemon_url="$(curl -fsSL https://api.github.com/repos/amadvance/snapraid-daemon/releases/latest \
    | grep "browser_download_url.*_${arch}.deb\"" \
    | cut -d '"' -f 4 \
    | head -n1)"

if [ -z "$snapraid_url" ]; then
    echo "No SnapRAID .deb found for ${arch}."
    exit 1
fi

if [ -z "$daemon_url" ]; then
    echo "No snapraid-daemon .deb found for ${arch}."
    exit 1
fi

snapraid_deb="$tmpdir/$(basename "$snapraid_url")"
daemon_deb="$tmpdir/$(basename "$daemon_url")"

curl -fsSL "$snapraid_url" -o "$snapraid_deb"
curl -fsSL "$daemon_url" -o "$daemon_deb"

snapraid_latest="$(dpkg-deb -f "$snapraid_deb" Version)"
daemon_latest="$(dpkg-deb -f "$daemon_deb" Version)"
snapraid_installed="$(dpkg-query -W -f='${Version}' snapraid 2>/dev/null || true)"
daemon_installed="$(dpkg-query -W -f='${Version}' snapraid-daemon 2>/dev/null || true)"
snapraid_status="$(version_status "$snapraid_installed" "$snapraid_latest")"
daemon_status="$(version_status "$daemon_installed" "$daemon_latest")"

echo
printf "%-18s %-29s %-25s %s\n" "Package" "Currently installed version" "Latest release (GitHub)" "Status"
printf "%-18s %-29s %-25s %s\n" "-------" "---------------------------" "-----------------------" "------"
printf "%-18s %-29s %-25s %s\n" "snapraid" "${snapraid_installed:-not installed}" "$snapraid_latest" "$snapraid_status"
printf "%-18s %-29s %-25s %s\n" "snapraid-daemon" "${daemon_installed:-not installed}" "$daemon_latest" "$daemon_status"
echo

if [ "$snapraid_installed" = "$snapraid_latest" ] && [ "$daemon_installed" = "$daemon_latest" ]; then
    echo "SnapRAID and snapraid-daemon are already up to date."
    exit 0
fi

if [ "$force" -ne 1 ]; then
    if [ ! -r /dev/tty ]; then
        echo "Refusing to run without --force because no interactive terminal is available."
        exit 1
    fi

    printf "Install or upgrade SnapRAID to %s and snapraid-daemon to %s? [y/N] " "$snapraid_latest" "$daemon_latest" > /dev/tty
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

$sudo_cmd apt install -y "$snapraid_deb" "$daemon_deb"
