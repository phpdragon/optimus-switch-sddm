# optimus-switch for SDDM
## Introduction
If you're using LightDM or GDM, you can get to those repo's here: https://github.com/dglt1. This includes an install script to remove conflicting configurations, blacklists, loading of drivers/modules.

*Made by a manjaro user for use with manjaro linux.* (other distros require modifications)

## Features
- It provides two modes of operation:
  - PRIME mode for best *performance* by utilizing nvidia GPU
  - intel mode for best *battery life* by utilizing intel GPU (see point below)
- In Intel mode, Nvidia GPU cannot be completely shut down, but it will display the non-call state (use 'lshw-c video' to see the NVIDIA GPU information)
- Does not negatively effect sleep/suspend cycles (hangs/lockups).
- Easy switching between two modes mentioned above.

## How to Use
### Requirements
Check `sudo mhwd -li` to see what video drivers are installed, if you have others, start by removing them like this:

`sudo mhwd -r pci video-driver-xxx` (remove any/all mhwd installed gpu drivers, xxx is replaced based on the command result above)

If you haven't installed any NVIDIA graphics drivers yet, do it now!

Install NVIDIA graphics driver for ASUS-W519L model notebook:
`sudo mhwd -f -i pci video-nvidia-390xx`

```bash
sudo bash -c 'cat >> /etc/modprobe.d/mhwd-gpu.conf <<EOF

# Resolved an issue with Nvidia graphics card driver tearing
options nvidia_drm modeset=1
EOF'

# Writes the kernel parameters configured above to the init image
sudo mkinitcpio -P
```

Run `sudo mhwd -li` again to see the currently installed drivers.
Output:
```text
> Installed PCI configs:
--------------------------------------------------------------------------------
                  NAME               VERSION          FREEDRIVER           TYPE
--------------------------------------------------------------------------------
    video-nvidia-390xx            2023.03.23               false            PCI
   network-broadcom-wl            2018.10.07               false            PCI
```
The above output shows that the Nvidia driver is installed。

！！！After performing the above operations, do not restart the system！！！

### Cleaning 
If you have any custom video/gpu .conf files in the following directories, backup/delete them (they can not remain there). The install script removes the most common ones, but custom file names won't be noticed (only you know if they exist) and clearing the entire directory would likely break other things, this install will not do that so clean up if necessary.
```
/etc/X11/
/etc/X11/mhwd.d/
/etc/X11/xorg.conf.d/
/etc/modprobe.d/
/etc/modules-load.d/
```
### Installation
In terminal, from your home directory ~/  (this is important for the install script to work properly)
 ```
git clone https://github.com/dglt1/optimus-switch-sddm.git
cd ~/optimus-switch-sddm
git switch ASUS-W519L && git pull
sudo sh ./install.sh
```
Done! After reboot you will be using intel/nvidia prime. 

To set modes (post installation) do:
- to change the default mode to intel only: `sudo set-intel.sh`
- to switch the default mode to intel/nvidia prime: `sudo set-nvidia.sh`
 
## Usage
NOTE: If you see errors about “*file does not exist*” while running `install.sh` its because it’s trying to remove the usual - mhwd-gpu/nvidia files that you may/may not have removed. 

Only errors after "copying" starts should be of any concern. If you could save the output of the install script if you are having issues this makes it much easier to troubleshoot.

## Usage after running install script:  

- `sudo set-intel.sh` will set intel only mode, reboot and nvidia powered off and removed from view.
- `sudo set-nvidia.sh` sets intel/nvidia (prime) mode.

This should be pretty straight forward, if however, you cant figure it out, I am @dglt on the manjaro forum. I hope this is as useful for you as it is for me.

Added side-note, for persistent changes to configurations, modify the configurations used for switching located in `/etc/switch/nvidia/`  and  `/etc/switch/intel/`.
