#!/usr/bin/env sh

## Add this to your wm startup file.

USERID=$1
HOME=$2

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $USERID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar -c $HOME/.config/polybar/config.ini main &
done

wait

# Launch bar1 and bar2
# polybar -c ~/.config/polybar/config.ini main &
