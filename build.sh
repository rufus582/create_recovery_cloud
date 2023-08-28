#!/bin/bash

echo "Starting Build"
cd ~/pbrp-12.1
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch twrp_m31s-eng
make recoveryimage -j$( nproc --all )
echo ""
