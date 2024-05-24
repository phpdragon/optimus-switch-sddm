#!/bin/sh

echo 'Removing intel only mode setup......'
rm -rf /etc/X11/mhwd.d/nvidia.conf
rm -rf /etc/modprobe.d/mhwd-gpu.conf
rm -rf /etc/modules-load.d/mhwd-gpu.conf

sleep 1
echo 'Setting nvidia prime mode.......'

cp -f /etc/switch/nvidia/nvidia-xorg.conf /etc/X11/mhwd.d/nvidia.conf
cp -f /etc/switch/nvidia/nvidia-modprobe.conf /etc/modprobe.d/mhwd-gpu.conf
cp -f /etc/switch/nvidia/nvidia-modules.conf /etc/modules-load.d/mhwd-gpu.conf

sleep 1
echo 'Done! After reboot you will be using nvidia prime mode.'

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
