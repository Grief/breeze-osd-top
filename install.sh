#!/usr/bin/env bash
set -e

base="$(dirname "${BASH_SOURCE[0]}")"
dir="${base}/osd"
bottomPatch="${base}/bottom.patch"

target1='/usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/osd'
target2='/usr/share/plasma/shells/org.kde.plasma.desktop/contents/osd'
backup1="${target1}.orig"
backup2="${target2}.orig"

case "$1" in
  'install')
    if [ -d "${backup1}" ] || [ -d "${backup2}" ]; then
       echo "breeze-os-top is already installed (use 'restore' to rollback or 'forget' to remove the backup)"
       exit 1
    fi
    sudo mv "${target1}" "${backup1}"
    sudo cp -ra "${dir}" "${target1}"
    sudo mv "${target2}" "${backup2}"
    sudo cp -ra "${dir}" "${target2}"
    if [ "$2" == 'bottom' ]; then
      patch -d "${target1}" < "${bottomPatch}"
      patch -d "${target2}" < "${bottomPatch}"
    fi
    sudo chown -R root:root "${target1}" "${target2}"
    ;;
  'restore')
    if [ ! -d "${backup1}" ] || [ ! -d "${backup2}" ]; then
       echo "breeze-os-top is not installed"
       exit 1
    fi
    sudo rm -rf "${target1}"
    sudo mv "${backup1}" "${target1}"
    sudo rm -rf "${target2}"
    sudo mv "${backup2}" "${target2}"
    ;;
  'forget')
      if [ ! -d "${backup1}" ] && [ ! -d "${backup2}" ]; then
         echo "breeze-os-top is not installed"
         exit 1
      fi
      sudo rm -rf "${backup1}" "${backup2}"
      exit 0
      ;;
  *)
    echo "Usage: $0 install | restore | forget"
    exit 0
esac

kquitapp5 plasmashell || echo 'Plasma is not running'
kstart5 plasmashell &>/dev/null
