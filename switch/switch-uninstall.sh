#!/bin/sh

#optimus-switch (SDDM) uninstall script.

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo 'Removing optimus-switch'

rm -rf /usr/local/bin/set-intel.sh
rm -rf /usr/local/bin/set-nvidia.sh
rm -rf /etc/switch

sleep 1
echo 'optimus-switch is now uninstalled'
echo '###################################'
echo 'setup another optimus solution before rebooting.'
