#!/bin/bash

echo "Starting Build"
cd ~/fox-10
export CURR_DEVICE=m31s
. build/envsetup.sh
lunch omni_m31s-eng
make recoveryimage
echo ""
