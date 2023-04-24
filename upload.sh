#!/bin/bash

echo "Uploading recovery image"
cd ~/twrp-11/out/target/product/*
version=$(cat ~/twrp-11/bootable/recovery/variables.h | grep "define TW_MAIN_VERSION_STR" | cut -d \" -f2)
version=$(echo $version | cut -c1-5)

mv recovery.img TWRP-11-${version}-m31s-$(TZ='Asia/Karachi' date "+%Y%m%d-%H%M").img

echo "Starting upload..."
# curl --upload-file $(ls TWRP*.img) https://transfer.sh/TWRP-m31s
curl -T $(ls TWRP*.img) temp.sh