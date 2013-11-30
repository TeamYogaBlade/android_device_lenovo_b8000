# Lenovo Yoga IdeaPad B8000 (Tablet 10) #

## Device Info ##
 * Recovery/Fastboot:  
   Hold down both volume up and volume down while turning the power on
 * Update .ZIP:  
   Yoga_tablet_10_A422_000_040_131023_WW_WIFI.rar:  
   * http://lenovo-forums.ru/topic/3182-rom-yoga-10-a422-000-040-131023-ww-wifi/
   * Direct: http://lenovo-forums.ru/files/go/baa7f9a098bab2c75e49be78eba416fb/rom-yoga-10-a422-000-040-131023-ww-wifiamp;agreed=1
  * adb pull /system/build.prop
<pre>
ro.product.manufacturer=LENOVO
ro.product.device=B8000
ro.product.board=blade10_row_wifi
</pre>
  * Processor: 1.2GHz MediaTek MT8125 quad-core  
    REQUIRES SPECIAL BOOT.IMG/RECOVERY.IMG UNPACK AND PACK TOOLS!  
    http://forum.xda-developers.com/showthread.php?t=1587411

## Work in progress... ##
 1. Install 64-bit Ubuntu on a VM (2GB RAM, 64GB Disk)
 1. sudo apt-get update
 1. sudo apt-get install bison build-essential curl flex git-core gnupg gperf libesd0-dev libncurses5-dev libsdl1.2-dev libwxgtk2.8-dev libxml2 libxml2-utils lzop openjdk-6-jdk openjdk-6-jre pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev
 1. sudo apt-get install g++-multilib gcc-multilib lib32ncurses5-dev lib32readline-gplv2-dev lib32z1-dev
 1. sudo apt-get install android-tools-adb android-tools-fastboot  
 1. mkdir -p ~/bin
 1. curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
 1. chmod a+x ~/bin/repo  
 1. sudo apt-get install emacs23
 1. emacs ~/.bashrc &
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

Uncharted Territory...  
The boot.img and recovery.img files in Lenovo's update .ZIP file [above] seem bad.  
They extract with no errors using either unpackbootimg or split_bootimg.pl.  
However, gunzip does not like the boot.img-ramdisk.gz or recovery.img-ramdisk.gz file.  
We need to figure out how to decompress and cpio those files:  
http://www.imajeenyus.com/computer/20130301_android_tablet/android/unpack_repack_recovery_image.html  

Maybe...  
http://en.wikipedia.org/wiki/Gzip#File_format  
"gzip" is often also used to refer to the gzip file format, which is:
 * a 10-byte header, containing a magic number (1f 8b), a version number and a timestamp
 * optional extra headers, such as the original file name,
 * a body, containing a DEFLATE-compressed payload
 * an 8-byte footer, containing a CRC-32 checksum and the length of the original uncompressed data.

recovery.img-ramdisk.gz starts with:
<pre>
                        R  E  C  O  V  E  R  Y
88 16 88 58 A6 7A 11 00 52 45 43 4F 56 45 52 59 00 ...
byte 40: FF ...
byte 512: 1F 8B 08 00 00 00 00 00 00 03 EC BD 0B 7C 54 D5 B5 30
</pre>
boot.img-ramdisk.gz starts with:
<pre>
                        R  O  O  T  F  S
88 16 88 58 3C 2B 0A 00 52 4F 4F 54 46 53 00 ...
byte 40: FF ...
byte 512: 1F 8B 08 00 00 00 00 00 00 03 EC BD 0D 7C 54 C5 D5 38
</pre>

Which is interesting, because recovery.img-zImage starts with:
<pre>
                        K  E  R  N  E  L
88 16 88 58 28 72 40 00 4B 45 52 4E 45 4C 00 ...
byte 40: FF ...
byte 512: 00 00 A0 E1 00 00 A0 E1 00 00 A0 E1 ...
</pre>
and boot.img-zImage starts with:
<pre>
                        K  E  R  N  E  L
88 16 88 58 28 72 40 00 4B 45 52 4E 45 4C 00 ...
byte 40: FF ...
byte 512: 00 00 A0 E1 00 00 A0 E1 00 00 A0 E1 ...
</pre>

That tells me that the .gz files are not compressed!


We need to recreate the boot.img file with the file renamed to boot.img-ramdisk:
 1. Download split_bootimg.pl https://gist.github.com/jberkel/1087743
 1. Extract boot.img from Yoga_tablet_10_A422_000_040_131023_WW_WIFI.rar
 1. split_bootimg.pl boot.img
 1. mv boot.img-ramdisk.gz boot.img-ramdisk
 1. mkbootimg --kernel boot.img-kernel --ramdisk boot.img-ramdisk -o boot.img

Back on track...  
build/tools/device/mkvendor.sh lenovo b8000 boot.img


Other References:
Using my old Galaxy Epic and LGOG as a guide:  
http://wiki.cyanogenmod.org/w/Build_for_epicmtd  
http://wiki.cyanogenmod.org/w/Build_for_ls970  
http://source.android.com/source/initializing.html  
http://forum.xda-developers.com/showthread.php?t=443994  

Lenovo Yoga 8/10 Tablet Open Source Code:  
http://mobilesupport.lenovo.com/en-us/products/yoga_tablet_10  
http://download.lenovo.com/consumer/open_source_code/b6000-8000_source_part1.zip  
http://download.lenovo.com/consumer/open_source_code/b6000-8000_source_part2.zip  
http://download.lenovo.com/consumer/open_source_code/b6000-8000_source_part3.zip  
Weird packaging:
<pre>
    part1 
        mediatek 
            build 
            config 
            custom 
            kernel 
            platform
    part2 
        kernel 
    part3 
        bionic 
        bootable 
        external 
</pre>

