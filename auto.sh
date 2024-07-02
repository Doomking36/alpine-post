#!/bin/sh

# Necessary package
doas apk add agetty

# Modify inittab
doas sed -i 's|/sbin/getty\(.*\)tty|/sbin/agetty --autologin $USER\1tty|' /etc/inittab

# Create profile
cat > "~/.profile" <<EOF
# Automatically updates system
doas apk update

# Automatically start sx
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  sx sh run.sh
  logout
fi
EOF
