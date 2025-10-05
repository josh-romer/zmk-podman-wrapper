#!/usr/bin/env bash

# Change to script directory
cd "$(dirname "$0")" || exit

# Clean all build artifacts and cloned repositories
rm -rf build/ zmk/ zmk-config/ out/

# Remove container image
podman rmi zmk 2>/dev/null || true

echo "Cleaned: build/, zmk/, zmk-config/, out/, and zmk container image"
