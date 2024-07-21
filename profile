#!/bin/sh

doas apk update

if [[ -z $"DISPLAY" ]] && [[ $(tty1) ]]; then
  sx sh run.sh
  logout
fi  
