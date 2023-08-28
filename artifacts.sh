#!/bin/bash

echo "Finishing up"
cd ~/pbrp-12.1/out/target/product/*
# version=$(cat ~/pbrp-12.1/bootable/recovery/variables.h | grep "define TW_MAIN_VERSION_STR" | cut -d \" -f2)
# version=$(echo $version | cut -c1-5)

mkdir ~/artifacts
ls -a
mv *.zip ~/artifacts/
