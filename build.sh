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

echo "Syncing SHRP-10 Sources"
mkdir ~/shrp-10
cd ~/shrp-10
repo init https://github.com/SHRP/platform_manifest_twrp_omni.git -b v3_10.0 --depth=1
repo sync -j $(nproc --all)

echo "Cloning trees"
cd ~/shrp-10
git clone https://github.com/rufus582/recovery_m31s -b shrp-10 ~/shrp-10/device/samsung/m31s
echo ""

echo "Starting Build"
cd ~/shrp-10
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL="C"
lunch omni_a51-eng
make recoveryimage
echo ""

echo "Uploading zip"
cd ~/shrp-10/out/target/product/m31s && ls

VERSION=$(cat ~/shrp-10/bootable/recovery/SHRPVARS.cpp | grep "shrp_ver" | cut -d \, -f2 | cut -d \" -f2)
cp recovery.img SHRP-10-$VERSION-a51-$(TZ=Asia/Karachi date +%Y%m%d-%H%M).img

curl -T $(ls SHRP*.zip) temp.sh
curl -T $(ls SHRP*.img) temp.sh

