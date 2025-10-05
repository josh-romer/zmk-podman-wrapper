#!/usr/bin/env bash

git clone https://github.com/zmkfirmware/zmk.git

git clone https://github.com/s-haha-n/zmk-config.git

podman build -t zmk -f Dockerfile ./zmk/.devcontainer/
