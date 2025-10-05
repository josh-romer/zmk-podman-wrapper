#!/usr/bin/env bash

# Change to script directory
cd "$(dirname "$0")" || exit

# podman run -it --rm --security-opt label=disable --workdir /workspaces/zmk -v ./zmk:/workspaces/zmk  -v ./zmk-config:/workspaces/zmk-config  -p 3000:3000  zmk '/bin/bash'
#
mkdir -p out build

# Pull latest config
cd zmk-config || exit ; git pull; cd .. || exit

# Create timestamped build directory
BUILD_DIR="$(date +%Y%m%d-%H%M%S)"
mkdir -p "out/$BUILD_DIR"

podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces/zmk \
  -v ./zmk:/workspaces/zmk \
  -v ./zmk-config:/workspaces/zmk-config \
  -v ./build:/workspaces/build \
  -v ./out:/workspaces/out \
  -p 3000:3000 \
  zmk /bin/bash -c "
    west init -l app/
    west update
    west zephyr-export
    cd app
    west build -d '/workspaces/build/left/' -b 'nice_nano_v2' -- -DZMK_CONFIG=/workpaces/zmk-config/config -DSHIELD='cradio_left'
    west build -d '/workspaces/build/right/' -b 'nice_nano_v2' -- -DZMK_CONFIG=/workpaces/zmk-config/config -DSHIELD='cradio_right'
    cp /workspaces/build/left/zephyr/zmk.uf2 /workspaces/out/$BUILD_DIR/cradio_left-nice_nano_v2-zmk.uf2
    cp /workspaces/build/right/zephyr/zmk.uf2 /workspaces/out/$BUILD_DIR/cradio_right-nice_nano_v2-zmk.uf2
  "

