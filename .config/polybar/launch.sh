#!/bin/sh

USERID="$1"
HOME="$2"

# Terminate already running bar instances
pkill -u "$USERID" polybar

# Wait until the processes have been shut down
while pgrep -u "$USERID" polybar >/dev/null; do sleep 1; done

MON_LIST=$(xrandr --listmonitors | tail -n +2 | cut -d ' ' -f 3 | tr -d '+*')

for m in $MON_LIST; do
    MONITOR="$m" polybar -c "$HOME/.config/polybar/config.ini" main &
done

wait

# Launch bar1 and bar2
# polybar -c ~/.config/polybar/config.ini main &
