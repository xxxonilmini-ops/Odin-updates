#!/usr/bin/env bash

iso_name="odinos"
iso_label="ODINOS_$(date +%Y%m)"
iso_publisher="OdinOS Project"
iso_application="OdinOS Live ISO"
iso_version="0.1.0"
install_dir="arch"
buildmodes=('iso')
bootmodes=(
  'bios.syslinux'
  'uefi.systemd-boot'
)
arch="x86_64"
pacman_conf="/etc/pacman.conf"
airootfs_image_type="squashfs"
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/customize_airootfs.sh"]="0:0:755"
  ["/usr/local/bin/vines-update-check"]="0:0:755"
  ["/usr/local/libexec/vines-update-install"]="0:0:755"
)
