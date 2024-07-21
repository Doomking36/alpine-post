#!/bin/sh

# Modify doas.conf for additional permissions
doas sh -c "echo 'permit persist :wheel' >> /etc/doas.d/doas.conf"
doas sh -c "echo 'permit nopass root' >> /etc/doas.d/doas.conf"
doas sh -c "echo 'permit nopass :wheel cmd reboot' >> /etc/doas.d/doas.conf"
doas sh -c "echo 'permit nopass :wheel cmd poweroff' >> /etc/doas.d/doas.conf"
doas sh -c "echo 'permit nopass :wheel cmd apk args update' >> /etc/doas.d/doas.conf"

# Install necessary packages
packages="sx neovim fastfetch make fontconfig-dev freetype-dev harfbuzz-dev libxft-dev imlib2-dev dash xsetroot font-terminus font-inconsolata font-dejavu font-noto font-noto-cjk font-awesome font-noto-extra font-liberation ttf-liberation font-jetbrains-mono-nerd gcc g++ libxinerama-dev alsa-lib alsa-utils picom feh rofi font-noto-extra ttf-liberation xf86-input-libinput pciutils ncurses udev dbus dbus-x11 firefox mesa-dri-gallium"
doas apk add $packages


# Clone necessary repositories and install
git clone https://github.com/siduck/chadwm --depth 1 ~/.config/chadwm
cd ~/.config/chadwm/chadwm && make && doas make install && cd ~/
cp ~/.config/chadwm/scripts/run.sh ~/

git clone https://github.com/lukesmithxyz/st
cd st && make && doas make install && cd ~/

git clone https://github.com/nvim-lua/kickstart.nvim ~/.config/nvim

# Add necessary groups
doas addgroup $USER video
doas addgroup $USER input
doas addgroup $USER audio
doas addgroup $USER tty

# Configure udev
doas rc-update add udev
doas rc-update add udev-trigger boot
doas rc-update add udev-settle boot
doas rc-update add udev-postmount boot

# Enable dbus
doas rc-update add dbus

# Update font cache
fc-cache -rv

echo "Post-installation setup is complete. Please reboot your system."
