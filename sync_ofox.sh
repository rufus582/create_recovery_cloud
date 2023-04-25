#!/bin/bash

echo "Syncing OFox"
git clone https://gitlab.com/orangefox/sync.git ; cd sync
./orangefox_sync.sh --debug --ssh 0 --path ~/fox-10 -b 10.0
cd ~/fox-10/vendor/recovery
echo "Applying patches"
echo "Patch 1"
git am /root/project/patches/0001-OrangeFox.sh-Use-bash-as-the-default-shell-if-bash-h.patch
echo "Patch 2"
git am /root/project/patches/0002-New-build-vars-FOX_DEBUG_BUILD_RAW_IMAGE-FOX_REPLACE.patch
# cp /root/project/files/AromaFM.zip ~/fox-10/vendor/recovery/FoxFiles/AromaFM/AromaFM.zip
echo ""
echo "~/fox-10/vendor/recovery/FoxFiles/"
ls ~/fox-10/vendor/recovery/FoxFiles/
echo ""
echo "~/fox-10/vendor/recovery/FoxFiles/AromaFM/"
ls ~/fox-10/vendor/recovery/FoxFiles/AromaFM/
echo "Done"
