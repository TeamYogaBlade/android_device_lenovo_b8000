# Lenovo Yoga 10" (b8000) Tablet

## Device Info ##
* Recovery/Fastboot:  
  Hold down both Volume-Up and Volume-Down while turning the power on
* Tools
  * MediaTek: http://mtk2000.ucoz.ru/load
    * Drivers: http://mtk2000.ucoz.ru/load/drajvera/1
    * Software: http://mtk2000.ucoz.ru/load/soft/4
  * MTK Droid Root & Tools (MDRT) (Windows Only):
    * http://forum.xda-developers.com/showthread.php?t=2160490
    * Windows USB Driver:
      * Standard:
        * On Device:
          * On Stock ROM, Settings->Storage->Connect As CD-ROM->Built-in CD-ROM
          * Open Windows Explorer to CD-ROM
          * Install LenovoUsbDriver_autorun_1.0.8.exe
        * Download:  
          http://lenovo-forums.ru/topic/3057-%D0%B4%D1%80%D0%B0%D0%B9%D0%B2%D0%B5%D1%80%D0%B0-lenovo-yoga-tablet/
          * Direct: http://lenovo-forums.ru/index.php?app=core&module=attach&section=attach&attach_id=7097
      * USB VCOM Driver (for [below] SmartPhone Flash Tool):
        * Download:  
          http://lenovo-forums.ru/topic/3057-%D0%B4%D1%80%D0%B0%D0%B9%D0%B2%D0%B5%D1%80%D0%B0-lenovo-yoga-tablet/
          * Direct: http://lenovo-forums.ru/index.php?app=core&module=attach&section=attach&attach_id=7098
    * Tutorials:
      * How To Root: http://forum.xda-developers.com/showpost.php?p=38337401&postcount=5
      * Problem Solving: http://forum.xda-developers.com/showpost.php?p=38369102&postcount=11
      * Backup and Flash: http://forum.xda-developers.com/showpost.php?p=44509214&postcount=407
      * Install ClockWorkMod Recovery: http://forum.xda-developers.com/showpost.php?p=44660171&postcount=417
  * SmartPhone Flash Tool (SPFT) (Windows Only):
    * Latest: v3.1328.0.sn183 http://www.google.com/webhp?q=SP+Flash+Tool
    * Tutorial: http://forum.xda-developers.com/showthread.php?t=1982587
    * Source Code (C/C++): v3.1320.0.175 http://mtk2000.ucoz.ru/load/soft/soft_mtk/sp_flash_tool_src/5-1-0-151
  * MTKRomStudio?
* Update .ZIP:  
  Yoga_tablet_10_A422_000_040_131023_WW_WIFI.rar:  
  * http://lenovo-forums.ru/topic/3182-rom-yoga-10-a422-000-040-131023-ww-wifi/
  * Direct:  
    http://lenovo-forums.ru/files/go/baa7f9a098bab2c75e49be78eba416fb/rom-yoga-10-a422-000-040-131023-ww-wifiamp;agreed=1
* Processor: MediaTek MT8125 (or MT8389) 1.2GHz Quad-Core
  * NOTE: MediaTek packs their boot.img and recovery.img a little differently.  
    Specifically the *-ramdisk.gz files have a 512 byte header that needs to be removed.  
    Something like the following needs to be done:
<pre>
mkdir recovery
cp Yoga_tablet_10_A422_000_040_131023_WW_WIFI/target_bin/target_bin/recovery.img .
unpackbootimg -i recovery.img
mkdir ramdisk
cd ramdisk
mv ../recovery.img-ramdisk.gz ../recovery.img-ramdisk-raw.gz
dd bs=512 skip=1 if=../recovery.img-ramdisk-raw.gz of=../recovery.img-ramdisk.gz
gunzip -c ../recovery.img-ramdisk.gz | cpio -i
</pre>
  * The first 512 bytes of the kernel files might also need to be removed.
  * The b8000/b6000 kernel code seems to be based off of the MT6589 CPU:  
    Examples:
    * https://github.com/TeamYogaBlade/lenovo_b6000-8000_source/tree/master/mediatek/config/mt6589
    * https://github.com/TeamYogaBlade/lenovo_b6000-8000_source/tree/master/mediatek/custom/mt6589
    * https://github.com/TeamYogaBlade/lenovo_b6000-8000_source/tree/master/mediatek/platform/mt6589
* Devices with the same processor (* = unconfirmed):
  * Lenovo Yoga 10" (b8000)  
    http://shop.lenovo.com/us/en/tablets/ideatab/yoga/yoga-10/#techspecs
  * Lenovo Yoga 8" (b6000)
    http://shop.lenovo.com/us/en/tablets/ideatab/yoga/yoga-8/#techspecs
  * Lenovo S6000  
    http://shop.lenovo.com/us/en/tablets/ideatab/s-series/s6000/#techspecs
  * Lenovo S5000
    http://shop.lenovo.com/us/en/tablets/ideatab/s-series/s5000#techspecs
  * Lenovo A3000  
    http://shop.lenovo.com/us/en/tablets/ideatab/a-series/a3000/#techspecs
  * Lenovo A2107A
  * ASUS MeMO Pad HD 7  
    http://www.asus.com/us/Tablets_Mobile/ASUS_MeMO_Pad_HD_7#specifications
  * GoClever Aries 785 (MT8389)  
    http://www.goclever.com/uk/products,c1/tablet,c5/aries-785,a149.html#specification

## Work in progress... ##
1. Install 64-bit Ubuntu on a VM (4GB RAM, 64GB Disk)  
   http://wiki.cyanogenmod.org/w/Doc:_using_virtual_machines#Install_VirtualBox
  1. Download and Install VirtualBox + Extensions: https://www.virtualbox.org/wiki/Downloads
  1. Download the latest Ubuntu 64-bit: http://www.ubuntu.com/download/desktop
  1. Create and Install Ubuntu (recommend 2 CPU, 4GB RAM, 32GB Disk, 32MB Video)
  1. Install VirtualBox Guest Additions on VM
1. Install the necessary build tools:
<pre>
sudo apt-get update
sudo apt-get install bison build-essential curl flex git-core gnupg gperf libesd0-dev libncurses5-dev libsdl1.2-dev libwxgtk2.8-dev libxml2 libxml2-utils lzop openjdk-7-jdk openjdk-7-jre pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev
sudo apt-get install g++-multilib gcc-multilib lib32ncurses5-dev lib32readline-gplv2-dev lib32z1-dev
sudo apt-get install android-tools-adb android-tools-fastboot
</pre>
1. Set up Git/GitHub:
  1. Set up GitHub SSH keys: https://help.github.com/articles/generating-ssh-keys
<pre>
ssh-keygen -t rsa -C "pv@swooby.com"
cd ~/.ssh
ssh-add id_rsa
sudo apt-get install xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
</pre>
    1. GitHub->SSH Keys->Add->Paste
    1. Test that everything is set up:
<pre>
ssh -T git@github.com
</pre>
  1. git config --global user.email "pv@swooby.com"
  1. git config --global user.name "paulpv"
1. Get the all important "repo" tool:
<pre>
mkdir -p ~/bin
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
</pre>
1. gedit ~/.bashrc &
<pre>
export USE_CCACHE=1
export PS1="[\t] \u@\h> "
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$HOME/bin:$PATH
export PATH=$PATH:$HOME/android/system/out/host/linux-x86/bin
</pre>
1. Close the current Terminal and open a new Terminal
1. Get the source code:
<pre>
mkdir -p ~/android/system
cd ~/android/system/
repo init -u git://github.com/CyanogenMod/android.git -b cm-10.1
repo sync -j4
</pre>
1. Wait several hours!
1. Prepare the build environment
<pre>
cd ~/android/system/vendor/cm
./get-prebuilts
cd ~/android/system/
make -j4 otatools
</pre>
1. Wait several hours!
1. Get/Create android_device_lenovo_b8000 repo:
  * Creator: Customize mkvendor.sh for MediaTek CPU
    1. gedit build/tools/device/mkvendor.sh
    1. Change:
<pre>
BOOTIMAGE=$3
</pre>
       -to-
<pre>
BOOTIMAGE=$3
SKIP=$4
</pre>
      Change:
<pre>
pushd ramdisk > /dev/null
gunzip -c ../$BOOTIMAGEFILE-ramdisk.gz | cpio -i
</pre>
       -to-
<pre>
pushd ramdisk > /dev/null
if [ ! -z "$SKIP" ]
then
  # Definitely discard the first $SKIP bytes
  mv ../$BOOTIMAGEFILE-ramdisk.gz ../$BOOTIMAGEFILE-ramdisk-raw.gz
  dd bs=$SKIP skip=1 if=../$BOOTIMAGEFILE-ramdisk-raw.gz of=../$BOOTIMAGEFILE-ramdisk.gz
fi
gunzip -c ../$BOOTIMAGEFILE-ramdisk.gz | cpio -i
</pre>
      1. adb pull /system/build.prop
<pre>
ro.product.manufacturer=LENOVO
ro.product.device=B8000
ro.product.board=blade10_row_wifi
</pre>
      1. build/tools/device/mkvendor.sh lenovo b8000 recovery.img 512
  * Contributor: Create a local manifest for the unofficial b8000 code
    1. gedit ~/android/system/.repo/local_manifests/lenovo_b8000.xml

```` xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <project path="device/lenovo/b8000" name="TeamYogaBlade/android_device_lenovo_b8000" remote="github" revision="master"/>
    <project path="kernel/lenovo/b8000" name="TeamYogaBlade/android_kernel_lenovo_b8000" remote="github" revision="master"/>
    <project path="kernel/lenovo/b8000/kernel_source" name="TeamYogaBlade/lenovo_b6000-8000_kernel_source" remote="github" revision="master"/>
</manifest>
````

1. Set up your CM device:
<pre>
. build/envsetup.sh
lunch
</pre>
1. Select "device_b8000"
1. Build a recovery image
<pre>
make recoveryimage
</pre>

Progress:
* I am having a hard time compiling the following kernel elements:
  1. mediatek/custom/out/lenovo89_tb_x10_jb2/kernel/usb/
<pre>
/bin/sh: 1: [: mediatek/custom/out/lenovo89_tb_x10_jb2/kernel/usb/: unexpected operator
</pre>
  1. net/netfilter/xt_mark.o
<pre>
CC      net/netfilter/xt_mark.o
net/netfilter/xt_mark.c:16:37: fatal error: linux/netfilter/xt_mark.h: No such file or directory
compilation terminated.
make[2]: *** [net/netfilter/xt_mark.o] Error 1
</pre>
     Fixed by commenting out (for now)
  1. net/netfilter/xt_connmark.o
<pre>
CC      net/netfilter/xt_connmark.o
net/netfilter/xt_connmark.c:29:41: fatal error: linux/netfilter/xt_connmark.h: No such file or directory
compilation terminated.
make[2]: *** [net/netfilter/xt_connmark.o] Error 1
</pre>
     Fixed by commenting out (for now)
  1. net/netfilter/xt_HL.o
<pre>
make[2]: *** No rule to make target `net/netfilter/xt_HL.o', needed by `net/netfilter/built-in.o'.  Stop.
</pre>
     Fixed by commenting out (for now)

Other References:
* Using my old Galaxy Epic and LGOG as a guide:
  * http://wiki.cyanogenmod.org/w/Build_for_epicmt
    * https://github.com/cyanogenmod/android_device_samsung_epicmtd
  * http://wiki.cyanogenmod.org/w/Build_for_ls970
    * https://github.com/cyanogenmod/android_device_lge_ls970
* http://source.android.com/source/initializing.html
* boot/recovery info:
  * http://forum.xda-developers.com/showthread.php?t=443994
  * http://www.imajeenyus.com/computer/20130301_android_tablet/android/unpack_repack_recovery_image.html
  * https://github.com/android/platform_system_core/blob/master/mkbootimg/bootimg.h
* MediaTek specific ideas:
  * https://github.com/bgcngm/mtk-tools
  * http://forum.xda-developers.com/showthread.php?t=1587411
  * https://github.com/oppo-source/R819-Kernel-Source-4.2/tree/master/
  * https://github.com/varunchitre15/MT6589_kernel_source/tree/master/
  * https://github.com/Shr3ps/kernel_acer_a1-810_MT8125
  * https://github.com/torvalds/linux

## TODO
1. Determine if we need an android_vendor_lenovo_b8000 repo; if so then create it
1. Set up the b8000 version of http://wiki.cyanogenmod.org/w/Template:Device_build  
   http://wiki.cyanogenmod.org/w/Documentation#Using_the_Device_Template
1. Set up a local manifest to pull from GitHub: http://wiki.cyanogenmod.org/w/Local_manifest
