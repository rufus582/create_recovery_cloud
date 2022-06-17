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

echo "Syncing TWRP-11"
mkdir ~/twrp-11
cd ~/twrp-11
repo init https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11 --depth=1
repo sync -j 20
#cp /drone/src/ui.xml ~/twrp-11/bootable/recovery/gui/theme/portrait_hdpi/ui.xml || exit 1
echo ""

echo "Cloning trees"
cd ~/twrp-11
git clone https://github.com/rufus582/android_device_recovery_samsung_m31s ~/twrp-11/device/samsung/m31s
echo ""

echo "Starting Build"
cd ~/twrp-11
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch twrp_m31s-eng
make recoveryimage -j$( nproc --all )
echo ""

echo "Uploading recovery image"
cd ~/twrp-11/out/target/product/*
version=$(cat ~/twrp-11/bootable/recovery/variables.h | grep "define TW_MAIN_VERSION_STR" | cut -d \" -f2)
version=$(echo $version | cut -c1-5)

mv recovery.img TWRP-11-${version}-m31s-$(TZ='Asia/Karachi' date "+%Y%m%d-%H%M").img
curl -sL https://git.io/file-transfer | sh
./transfer wet $(ls TWRP*.img)
