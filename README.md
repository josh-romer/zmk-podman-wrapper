# ZMK Build Setup

## Project Structure

This project contains two sub-repositories:
- `zmk` - The ZMK firmware repository
- `zmk-config` - Your ZMK configuration

## Setup

1. Create the container:
   ```bash
   ./create-container.sh
   ```
   This will clone the ZMK repository and build the container image.

2. Build the configuration:
   ```bash
   ./build-config.sh
   ```
   This will run the build process inside the container.

## Output

Build artifacts will be placed in timestamped directories under `./out`.

Example output:
```
out/
└── 20251005-143022/
    ├── cradio_left-nice_nano_v2-zmk.uf2
    └── cradio_right-nice_nano_v2-zmk.uf2
```

Flash the `.uf2` files to your keyboard by copying them to the bootloader drive.

## Cleaning

To remove all build artifacts, cloned repositories, and the container image:
```bash
./clean.sh
```

This will delete: `build/`, `zmk/`, `zmk-config/`, `out/`, and the `zmk` container image.
