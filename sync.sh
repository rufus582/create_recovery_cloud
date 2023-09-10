#!/bin/bash

echo "Syncing PBRP-12.1"
mkdir ~/pbrp-12.1
cd ~/pbrp-12.1
repo init -u https://github.com/PitchBlackRecoveryProject/manifest_pb -b android-12.1
repo sync -j 20
echo ""

echo "Cloning trees"
cd ~/pbrp-12.1
git clone https://github.com/rufus582/twrp_device_samsung_universal9611 ~/pbrp-12.1/device/samsung/universal9611
echo ""

# echo "Copy ui.xml from device tree"
# cp ~/pbrp-12.1/device/samsung/m31s/ui.xml ~/pbrp-12.1/bootable/recovery/gui/theme/portrait_hdpi/
# echo ""