#!/bin/sh

cd /var/lib/flatpak
doas mkdir -p repo/objects repo/tmp
doas tee repo/config <<EOF
[core]
repo_version=1
mode=bare-user-only
min-free-space-size=500MB
EOF
