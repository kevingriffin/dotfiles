#! /usr/bin/env bash
hostname=$(hostname -s)
if [ -f "$hostname"/authorized_keys ]
then
  cp "$hostname"/authorized_keys "$HOME"/.ssh/authorized_keys
else
  cp authorized_keys "$HOME"/.ssh/authorized_keys
fi
