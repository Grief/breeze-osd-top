#!/usr/bin/env bash
set -e

dir="$(dirname "${BASH_SOURCE[0]}")/osd"
target='/usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/osd'
backup="${target}.orig"

case "$1" in
  'install')
    if [ -d "${backup}" ]; then
       echo "breeze-os-top is already installed"
       exit 1
    fi
    sudo mv "${target}" "${backup}"
    sudo cp -ra "${dir}" "${target}"
    sudo chown -R root:root "${target}"
    ;;
  'restore')
    if [ ! -d "${backup}" ]; then
       echo "breeze-os-top is not installed"
       exit 1
    fi
    sudo rm -rf "${target}"
    sudo mv "${backup}" "${target}"
    ;;
  *)
    echo "Usage: $0 install | restore"
    exit 0
esac

kquitapp5 plasmashell || echo 'Plasma is not running'
kstart5 plasmashell &>/dev/null