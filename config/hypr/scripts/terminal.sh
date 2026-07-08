#!/bin/bash

KITTY=/home/alf/.nix-profile/bin/kitty
TMUX=/home/alf/.nix-profile/bin/tmux
HYPRCTL=/usr/bin/hyprctl
SOCKET=unix:@mykitty

has_kitty=$($HYPRCTL clients -j | /usr/bin/grep -c '"kitty"')

if [ "$has_kitty" -eq 0 ]; then
    $KITTY --listen-on=$SOCKET -- $TMUX new-session -A -s main &
    disown
    sleep 0.5
elif ! $TMUX has-session -t main 2>/dev/null; then
    $KITTY --listen-on=$SOCKET -- $TMUX new-session -A -s main &
    disown
else
    $TMUX new-window -t main
fi

$HYPRCTL dispatch focuswindow kitty
$HYPRCTL dispatch workspace 2
