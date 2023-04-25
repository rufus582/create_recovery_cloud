#!/bin/bash

echo "Cloning trees"
cd ~/fox-10
git clone https://github.com/rufus582/recovery_m31s -b ofox-10 ~/fox-10/device/samsung/m31s
echo "Downloading Magisk"
cd ~/fox-10/device/samsung/m31s/
wget https://github.com/topjohnwu/Magisk/releases/download/v26.1/Magisk-v26.1.apk
export FOX_USE_SPECIFIC_MAGISK_ZIP="$HOME/fox-10/device/samsung/m31s/Magisk*.apk"
echo "Done"
