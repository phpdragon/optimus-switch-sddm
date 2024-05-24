#!/bin/sh

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

####################################
# custom install script for SDDM   #
# and following GPU BusID's        #
# intel iGPU BusID  00:02:0        #
# nvidia dGPU BusID  01:00:0       #
# chmod +x install.sh  first!      #
####################################



echo '##################################################################'
echo '# be sure you have all requirements BEFORE running this script  ##'
echo '# video-nvidia-390xx                                            ##'
echo '# ****installing in 5 sec... CTRL+C to abort****                ##'
echo '##################################################################'
sleep 6
echo ' '
echo '##################################################################'
echo '#errors about removing files can be ignored, i wrote this script##'
echo '#with the most common files in mind, you will not have all of   ##'
echo '#them, this is ok!                                              ##'
echo '##################################################################'
echo '## IF YOU HAVE ERRORS ABOUT COPYING FILES, SOMETHING IS WRONG   ##'
echo '## MAKE SURE THIS IS RUN WITH SUDO AND FROM DIRECTORY           ##'
echo '## ~/optimus-switch-sddm/  (this is very important!!!)          ##'
echo '##################################################################'
sleep 5

echo ' '
echo 'Removing current nvidia prime setup if applicable, file not found can be ignored......'
rm -rf /etc/X11/mhwd.d/nvidia.conf
rm -rf /etc/X11/mhwd.d/nvidia.conf.nvidia-xconfig-original
echo 'Removing gpu configurations from /etc/X11/mhwd.d/  .......'
rm -rf /etc/X11/xorg.conf.d/90-mhwd.conf
rm -rf /etc/X11/xorg.conf.d/optimus.conf
rm -rf /etc/X11/xorg.conf.d/20-intel.conf
rm -rf /etc/X11/xorg.conf.d/nvidia.conf
rm -rf /etc/X11/xorg.conf.d/xorg.conf
echo 'Removing gpu configurations from /etc/X11/xorg.conf.d/ ........'
#rm -rf /etc/modprobe.d/mhwd-gpu.conf
rm -rf /etc/modprobe.d/optimus.conf
rm -rf /etc/modprobe.d/nvidia.conf
echo 'Removing gpu configurations from /etc/modprobe.d/  ........'
rm -rf /etc/modprobe.d/nvidia-drm.conf
rm -rf /etc/modprobe.d/nvidia.conf
echo 'Removing gpu configurations from /etc/modules-load.d/'
#rm -rf /etc/modules-load.d/mhwd-gpu.conf
echo 'removing any display setup scripts.....'
rm -rf /usr/local/share/optimus.desktop
rm -rf /usr/local/bin/optimus.sh
sleep 2

echo 'Copying contents of ~/optimus-switch-sddm/* to /etc/ .......'
mkdir -p /etc/switch/
cp -r switch /etc/
cp README*.md /etc/switch/

sleep 2
echo 'Copying set-intel.sh and set-nvidia.sh to /usr/local/bin/'

ln -sf /etc/switch/set-intel.sh /usr/local/bin/set-intel.sh
ln -sf /etc/switch/set-nvidia.sh /usr/local/bin/set-nvidia.sh

sleep 1
echo ' '
echo 'Setting permissions........'
chmod +x /etc/switch/set-intel.sh
chmod +x /etc/switch/set-nvidia.sh

sleep 1
echo ' '
echo 'Setting nvidia prime mode (sudo set-nvidia.sh).......'
cp -f /etc/switch/nvidia/nvidia-xorg.conf /etc/X11/mhwd.d/nvidia.conf

sleep 1
echo ' '
echo ' '
echo 'Currently boot mode is set to nvidia prime.'
echo ' '
echo 'you can switch to intel only mode with sudo set-intel.sh and reboot.'
echo ' '
echo 'same can be done for nvidia prime mode with sudo set-nvidia.sh'
echo ' '
echo ' '
sleep 1
echo 'Install finished!'
echo ' '
