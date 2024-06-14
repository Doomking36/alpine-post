#!/bin/sh

# Modify repositories to include main and community
doas sh -c "echo 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.20/main' > /etc/apk/repositories"
doas sh -c "echo 'https://mirror.math.princeton.edu/pub/alpinelinux/v3.20/community' >> /etc/apk/repositories"

# Update and upgrade the system
doas apk update
doas apk upgrade

# Install necessary packages
packages="sx neovim fastfetch git make fontconfig-dev freetype-dev harfbuzz-dev libxft-dev imlib2-dev dash xsetroot font-jetbrains-mono-nerd gcc g++ libzinerama-dev alsa-lib alsa-utils picom feh rofi font-noto-extra ttf-liberation xf86-input-libinput pciutils ncurses udev firefox"
doas apk add $packages

# Modify doas.conf for additional permissions
doas sh -c "echo 'permit persist :wheel' >> /etc/doas.conf"
doas sh -c "echo 'permit nopass root' >> /etc/doas.conf"
doas sh -c "echo 'permit persist :wheel cmd reboot' >> /etc/doas.conf"
doas sh -c "echo 'permit persist :wheel cmd poweroff' >> /etc/doas.conf"

# Clone necessary repositories and install
git clone https://github.com/siduck/chadwm --depth 1 ~/.config/chadwm
cd ~/.config/chadwm/chadwm && make && doas make install && cd
cp ~/.config/chadwm/scripts/run.sh ~/

git clone https://github.com/lukesmithxyz/st
cd st && make && doas make install && cd

git clone https://github.com/nvim-lua/kickstart.nvim ~/.config/nvim

# Add necessary groups
doas addgroup dk video
doas addgroup dk input
doas addgroup dk audio
doas addgroup dk tty

# Configure udev
doas rc-update add udev
doas rc-update add udev-trigger boot
doas rc-update add udev-settle boot
doas rc-update add udev-postmount boot

# Update font cache
fc-cache -rv

echo "Post-installation setup is complete. Please reboot your system."
