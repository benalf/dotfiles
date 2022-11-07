#!/bin/bash

picom --experimental-backends --config $HOME/.config/qtile/scripts/picom.conf &
nitrogen --restore &
eval `ssh-agent -s`
