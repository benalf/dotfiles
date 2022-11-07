#!/bin/bash

picom --experimental-backends --config $HOME/.config/qtile/scripts/picom.conf &
nitrogen --restore &
nm-applet &
eval `ssh-agent -s`
