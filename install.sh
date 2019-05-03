#! /usr/bin/env bash
hostname=$(hostname -s)
if [ -f hosts/"$hostname"/authorized_keys ]
then
  cp hosts/"$hostname"/authorized_keys "$HOME"/.ssh/authorized_keys
else
  cp authorized_keys "$HOME"/.ssh/authorized_keys
fi
