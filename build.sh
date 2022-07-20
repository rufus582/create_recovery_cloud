#!/bin/bash

echo "Executing Build Script"
echo ""
echo ""
echo "Making sure the required dependencies are there"
echo ""
apt update --fix-missing
apt install openssh-server -y
apt install git-core gnupg flex bison build-essential \
zip curl zlib1g-dev gcc-multilib g++-multilib \
libc6-dev-i386 libncurses5-dev lib32ncurses5-dev \
x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
libxml2-utils xsltproc unzip fontconfig openjdk-8-jdk -y

echo "Installing the repo launcher"
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
echo ""

echo "Configuring git"
git config --global user.name "rufus582"
git config --global user.email "rufus5802@gmail.com"
echo "Installed all the dependencies"
echo ""
echo ""

echo "Files in /root/project"
ls /root/project

echo "Syncing OFox"
git clone https://gitlab.com/orangefox/sync.git ; cd sync
./orangefox_sync.sh --debug --ssh 0 --path ~/fox-10 -b 10.0
cd ~/fox-10/vendor/recovery
echo "Applying patches"
echo "Patch 1"
git am /root/project/patches/0001-OrangeFox.sh-Use-bash-as-the-default-shell-if-bash-h.patch
echo "Patch 2"
git am /root/project/patches/0002-New-build-vars-FOX_DEBUG_BUILD_RAW_IMAGE-FOX_REPLACE.patch
cp /root/project/files/AromaFM.zip ~/fox-10/vendor/recovery/FoxFiles/AromaFM/AromaFM.zip
echo ""

echo "Cloning trees"
cd ~/fox-10
git clone https://github.com/rufus582/recovery_ofox_m31s -b fox_10.0 ~/fox-10/device/samsung/m31s
echo "Download Magisk-v24.3.apk"
cd ~/fox-10/device/samsung/m31s/
wget https://github.com/topjohnwu/Magisk/releases/download/v25.1/Magisk-v25.1.apk
export FOX_USE_SPECIFIC_MAGISK_ZIP="$HOME/fox-10/device/samsung/m31s/Magisk-v25.1.apk"
echo ""

echo "Starting Build"
cd ~/fox-10
export CURR_DEVICE=m31s
. build/envsetup.sh
lunch omni_m31s-eng
make recoveryimage
echo ""

echo "Uploading zip"
cd ~/fox-10/out/target/product/m31s && ls
curl -sL https://git.io/file-transfer | sh
./transfer wet $(ls OrangeFox*.zip)
