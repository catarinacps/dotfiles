#!/bin/sh

THEME=/usr/share/icons/$(gsettings get org.gnome.desktop.interface icon-theme | tr -d \')

ICON="$THEME/32x32/apps/system-software-update.svg"

SHORT_SLEEP=300
LONG_SLEEP=1800

while true; do
    UPDATES="$(checkupdates 2>/dev/null)"

    if [ $? -eq 0 ]; then
        QTY=$(echo -e "$UPDATES" | wc -l)

        [ $QTY -gt 50 ] && URGENCY='critical' || URGENCY='normal'

        [ $QTY -gt 1 ] && PLURAL='s'

        notify-send \
            -u "$URGENCY" \
            -i "$ICON" \
            "Update$PLURAL available" \
            "$QTY new package$PLURAL"

        echo "$QTY update$PLURAL"  | tr [:lower:] [:upper:]

        sleep $SHORT_SLEEP
    else
        echo

        sleep $LONG_SLEEP
    fi
done
