#!/usr/bin/env bash
set -e

systemctl enable NetworkManager.service
systemctl enable sddm.service
systemctl --global enable vines-updater.timer

useradd --create-home --groups wheel,audio,video,storage,optical --shell /bin/bash odin
passwd --delete odin
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
locale-gen
su -s /bin/bash - odin -c xdg-user-dirs-update
