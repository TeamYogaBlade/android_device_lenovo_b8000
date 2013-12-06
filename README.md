# Lenovo Yoga IdeaPad B8000 (Tablet 10) #

## Device Info ##
* Recovery/Fastboot:  
  Hold down both Volume-Up and Volume-Down while turning the power on
* Tools
  * MediaTek: http://mtk2000.ucoz.ru/load
    * Drivers: http://mtk2000.ucoz.ru/load/drajvera/1
    * Software: http://mtk2000.ucoz.ru/load/soft/4
  * MTK Droid Root & Tools (MDRT) (Windows Only):
    * http://forum.xda-developers.com/showthread.php?t=2160490
    * Windows Driver:
      * On Stock ROM, Settings->Storage->Connect As CD-ROM->Built-in CD-ROM
      * Open Windows Explorer to CD-ROM
      * Install LenovoUsbDriver_autorun_1.0.8.exe
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
  * Direct: http://lenovo-forums.ru/files/go/baa7f9a098bab2c75e49be78eba416fb/rom-yoga-10-a422-000-040-131023-ww-wifiamp;agreed=1
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
* Devices with the same processor (* = unconfirmed):
  * Lenovo Yoga B8000 (10")
  * Lenovo Yoga B6000 (8")
  * Lenovo S6000
  * Lenovo S5000
  * Lenovo A3000
  * Lenovo A2107A
  * Asus MemoPad HD7
  * GoClever Aries 785 (MT8389)

## Work in progress... ##
 1. Install 64-bit Ubuntu on a VM (4GB RAM, 64GB Disk)
 1. sudo apt-get update
 1. sudo apt-get install bison build-essential curl flex git-core gnupg gperf libesd0-dev libncurses5-dev libsdl1.2-dev libwxgtk2.8-dev libxml2 libxml2-utils lzop openjdk-6-jdk openjdk-6-jre pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev
 1. sudo apt-get install g++-multilib gcc-multilib lib32ncurses5-dev lib32readline-gplv2-dev lib32z1-dev
 1. sudo apt-get install android-tools-adb android-tools-fastboot
 1. mkdir -p ~/bin
 1. curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
 1. chmod a+x ~/bin/repo
 1. gedit ~/.bashrc &
<pre>
export USE_CCACHE=1
export PS1="[\t] \u@\h> "
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$HOME/bin:$PATH
export PATH=$PATH:$HOME/android/system/out/host/linux-x86/bin
</pre>
 1. Close and open a new Terminal
 1. Set up GitHub SSH keys
   1. https://help.github.com/articles/generating-ssh-keys
   1. ssh-keygen -t rsa -C "pv@swooby.com"
   1. cd ~/.ssh
   1. ssh-add id_rsa
   1. sudo apt-get install xclip
   1. xclip -sel clip < ~/.ssh/id_rsa.pub
   1. GitHub->SSH Keys->Add->Paste
   1. ssh -T git@github.com
 1. git config --global user.email "pv@swooby.com"
 1. git config --global user.name "Paul Peavyhouse"
 1. mkdir -p ~/android/system
 1. cd ~/android/system/
 1. repo init -u git://github.com/CyanogenMod/android.git -b cm-10.1
 1. repo sync
 1. Wait several hours!
 1. make -j4 otatools
 1. Wait several hours!
 1. Customize mkvendor.sh for MediaTek CPU:
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
   1. Change:
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
 1. ...

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

Lenovo Yoga 8/10 Tablet Open Source Code:
* http://mobilesupport.lenovo.com/en-us/products/yoga_tablet_10?tabname=downloads  
  Weird packaging:
  * http://download.lenovo.com/consumer/open_source_code/b6000-8000_source_part1.zip
    * mediatek
      * build
      * config
      * custom
      * kernel
      * platform
  * http://download.lenovo.com/consumer/open_source_code/b6000-8000_source_part2.zip
    * kernel
  * http://download.lenovo.com/consumer/open_source_code/b6000-8000_source_part3.zip
    * bionic
    * bootable
    * external


