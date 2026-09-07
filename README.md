# OdinOS

OdinOS is a custom operating system based on Arch Linux.
It has its own interface, default programs, branding, and update system.

## What is here

- `profile/profiledef.sh`: OdinOS ISO metadata and boot modes
- `profile/packages.x86_64`: packages included in the image
- `profile/airootfs`: files copied into the live system
- `scripts/build.sh`: convenience wrapper for building the image
- `GITHUB-UPDATES.md`: инструкция по публикации собственных обновлений
- `.github/workflows/publish-vines-update.yml`: автоматическая сборка и публикация обновления

## Requirements

Build on Arch Linux, or inside an Arch Linux virtual machine/container.
Building directly on Windows is not supported by `archiso`; WSL2 or a VM is the simplest route.

Install the Arch ISO toolchain:

```bash
sudo pacman -Syu archiso
```

## Build

```bash
bash scripts/build.sh
```

The ISO is written to `artifacts/` when the build succeeds.

## Customize

- Add or remove packages in `profile/packages.x86_64`.
- Put files under `profile/airootfs/` to customize the live system.
- Edit `profile/profiledef.sh` to change the ISO name, version, and boot modes.

## OdinOS updates

The profile includes a user-level updater. It checks for a new OdinOS release every three days, asks before downloading, verifies the SHA-256 hash and Minisign signature, installs the signed `odinos-system` package, and keeps the previous package for rollback.

Before publishing an ISO, replace the placeholder URL and public key in `profile/airootfs/etc/vines/vines-updater.conf`. Each release manifest must contain `version`, `package_url`, `sha256`, and `signature_url` fields.

## Suggested next step

The current image includes a KDE Plasma desktop and is intended to boot into a usable Live session. Next we can add:

- minimal console system
- XFCE desktop
- GNOME desktop
- gaming / multimedia image
- privacy-focused image
