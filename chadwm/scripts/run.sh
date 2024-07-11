#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
#feh --bg-fill ~/Pictures/wall/gruv.png &
xset r rate 200 50 &
picom &
nitrogen --restore &
#xrandr --output eDP-1 --off &
# xrandr --output eDP-2 --off &
xrandr --output DP-2 --off &

dash ~/.config/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
