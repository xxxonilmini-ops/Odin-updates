#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE_DIR="${PROFILE_DIR:-$ROOT_DIR/profile}"
OUTPUT_DIR="${OUTPUT_DIR:-$ROOT_DIR/artifacts}"
WORK_DIR="${WORK_DIR:-/var/tmp/odinos-archiso-work}"

if ! command -v mkarchiso >/dev/null 2>&1; then
  echo "archiso (mkarchiso) is not installed." >&2
  echo "Install it on Arch Linux with: sudo pacman -S archiso" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

BASELINE_DIR="/usr/share/archiso/configs/baseline"
mkdir -p "$PROFILE_DIR/airootfs"
cp -an "$BASELINE_DIR/airootfs/." "$PROFILE_DIR/airootfs/"
for boot_dir in efiboot syslinux; do
  if [ ! -d "$PROFILE_DIR/$boot_dir" ]; then
    cp -a "$BASELINE_DIR/$boot_dir" "$PROFILE_DIR/"
  fi
done

mkarchiso -v -w "$WORK_DIR" -o "$OUTPUT_DIR" "$PROFILE_DIR"
echo "ISO files are available in $OUTPUT_DIR"
