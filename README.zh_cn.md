# optimus-switch for SDDM
## 介绍

如果你正在使用LightDM或GDM，你可以使用这个仓库:https://github.com/dglt1。这包括一个安装脚本，以删除冲突的配置，黑名单，加载驱动程序/模块。

*由manjaro用户制作，用于manjaro linux。*(其他发行版需要修改)

## 特性
- 它提供两种操作模式:
  - PRIME模式最佳*性能*利用英伟达GPU
  - 利用英特尔显卡的最佳电池寿命模式(见下文)
- 在英特尔模式下，英伟达显卡完全关闭 (使用 `inxi -G` 或者 `lspci -v | grep -E 'VGA|3D'` 命令将不可见到Nvidia显卡信息)
- 不会对睡眠/挂起周期(挂起/锁定)产生负面影响。
- 在上述两种模式之间轻松切换。

## 如何使用
### 必要依赖
首先执行`sudo mhwd -li`查看系统安装了哪些显卡驱动程序，如果有其他驱动程序，请像这样开始删除它们:

`sudo mhwd -r pci video-driver-xxx` (删除任何/所有mhwd安装的显卡驱动程序，根据上面命令的结果替换xxx)

如果你还没有安装任何英伟达图形驱动程序，现在就开始安装！

安装英伟达显卡驱动，适合ASUS-W519L型号笔记本:
`sudo mhwd -f -i pci video-nvidia-390xx`

```bash
sudo bash -c 'cat >> /etc/modprobe.d/mhwd-gpu.conf <<EOF

# 解决英伟达显卡驱动画面撕裂的问题
options nvidia_drm modeset=1
EOF'

# 把上面配置的内核参数写入到引导镜像
sudo mkinitcpio -P
```
再次运行`sudo mhwd -li`查看当前安装的驱动程序。
输出:
```text
> Installed PCI configs:
--------------------------------------------------------------------------------
                  NAME               VERSION          FREEDRIVER           TYPE
--------------------------------------------------------------------------------
    video-nvidia-390xx            2023.03.23               false            PCI
   network-broadcom-wl            2018.10.07               false            PCI
```
以上输出说明Nvidia驱动已经安装。

！！！执行以上操作后，请勿重启系统！！！

### 清理
如果您在以下目录下有自定义 video/gpu .conf 配置文件，请备份/删除它们(它们不能留在那里)。
安装脚本删除了最常见的配置文件，但是不会注意到自定义文件名(只有您知道它们是否存在)，并且清除整个目录可能会破坏其他东西，这个安装脚本不会这样做，所以如果有必要，请清理你的自定义配置。

```
/etc/X11/
/etc/X11/mhwd.d/
/etc/X11/xorg.conf.d/
/etc/modprobe.d/
/etc/modules-load.d/
```

### 安装
在终端中，进入你的主目录 ~/ (这对于安装脚本的正常工作很重要)，克隆当前项目的代码
 ```
git clone https://github.com/dglt1/optimus-switch-sddm.git
cd ~/optimus-switch-sddm
git switch ASUS-W519L && git pull
sudo sh ./install.sh
```

完成后并重启后，您将使用英特尔/英伟达prime。

要设置模式(安装后)，请执行以下操作:
- 将默认模式切换为英特尔模式: `sudo set-intel.sh`
- 将默认模式切换为英伟达模式: `sudo set-nvidia.sh`

## 使用说明
请注意: 如果你在运行`install.sh`时看到关于“*file does not exist*”的错误，这是因为它试图删除通常的- mhwd-gpu/nvidia 文件，你可能没有删除它们。

只有在“复制”开始后出现的错误才应该引起注意。如果您可以在遇到问题时保存安装脚本的输出，这将使故障排除变得容易得多。

## 运行安装脚本后的用法:

- `sudo set-intel.sh` 将设置为英特尔模式并重启生效，英伟达将断电并从视图中删除。
- `sudo set-nvidia.sh` 将设置为英伟达(prime)模式并重启生效.

这应该是相当直接的，但是，如果你不能弄清楚, 请在Manjaro论坛 @dglt, 希望这对你有帮助。

对于更改配置，请修改位于`/etc/switch/nvidia/`和`/etc/switch/intel/`中的用于切换的配置文件。
