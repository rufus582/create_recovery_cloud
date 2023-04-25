#!/bin/bash

echo "Finishing up"
cd ~/twrp-11/out/target/product/*
version=$(cat ~/twrp-11/bootable/recovery/variables.h | grep "define TW_MAIN_VERSION_STR" | cut -d \" -f2)
version=$(echo $version | cut -c1-5)

mkdir ~/artifacts
mv recovery.img ~/artifacts/TWRP-11-${version}-m31s-$(TZ='Asia/Karachi' date "+%Y%m%d-%H%M").img
