#!/bin/sh

#unless you replace intel-xorg.conf
#with modeset.xorg.conf on the line below.
echo 'Removing nvidia prime setup......'

rm -rf /etc/X11/mhwd.d/nvidia.conf
rm -rf /etc/modprobe.d/mhwd-gpu.conf
rm -rf /etc/modules-load.d/mhwd-gpu.conf

sleep 1
echo 'Setting intel only mode.......'
cp -f /etc/switch/intel/modeset-xorg.conf /etc/X11/mhwd.d/nvidia.conf
cp -f /etc/switch/intel/intel-modprobe.conf /etc/modprobe.d/mhwd-gpu.conf

sleep 1
echo 'Done! After reboot you will be using intel only mode.'

read -n 1 -p "Are you sure you want to reboot now ? (y/n) [n]:" answer
case ${answer} in
   y | Y)
      echo ""
      echo ""
      echo "Rebooting......"
      echo ""
      reboot
      ;;
   *)
      echo ""
      echo ""
      ;;
esac
