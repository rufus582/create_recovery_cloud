#!/bin/bash

echo "Syncing TWRP-11"
mkdir ~/twrp-11
cd ~/twrp-11
repo init https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11 --depth=1
repo sync -j 20
echo ""

echo "Cloning trees"
cd ~/twrp-11
git clone https://github.com/rufus582/recovery_m31s ~/twrp-11/device/samsung/m31s
echo ""

# echo "Copy ui.xml from device tree"
# cp ~/twrp-11/device/samsung/m31s/ui.xml ~/twrp-11/bootable/recovery/gui/theme/portrait_hdpi/
# echo ""