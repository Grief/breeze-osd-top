#!/usr/bin/env bash
set -e

base="$(dirname "${BASH_SOURCE[0]}")"
dir="${base}/osd"
bottomPatch="${base}/bottom.patch"

target='/usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/osd'
backup="${target}.orig"

case "$1" in
  'install')
    if [ -d "${backup}" ]; then
       echo "breeze-os-top is already installed (use 'restore' to rollback or 'forget' to remove the backup)"
       exit 1
    fi
    sudo mv "${target}" "${backup}"
    sudo cp -ra "${dir}" "${target}"
    if [ "$2" == 'bottom' ]; then
      patch -d "${target}" < "${bottomPatch}"
    fi
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
  'forget')
      if [ ! -d "${backup}" ]; then
         echo "breeze-os-top is not installed"
         exit 1
      fi
      sudo rm -rf "${backup}"
      exit 0
      ;;
  *)
    echo "Usage: $0 install | restore | forget"
    exit 0
esac

kquitapp5 plasmashell || echo 'Plasma is not running'
kstart5 plasmashell &>/dev/null
