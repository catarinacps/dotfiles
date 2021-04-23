#!/bin/sh

THEME="/usr/share/icons/$(gsettings get org.gnome.desktop.interface icon-theme | tr -d \')"

ICON="$THEME/32x32/apps/system-software-update.svg"

SHORT_SLEEP=300
LONG_SLEEP=$((SHORT_SLEEP * 3))

while true; do
    if UPDATES="$(checkupdates 2>/dev/null)"; then
        QTY="$(printf '%s\n' "$UPDATES" | wc -l)"

        [ "$QTY" -gt 50 ] && URGENCY='critical' || URGENCY='normal'

        [ "$QTY" -gt 1 ] && PLURAL='s'

        notify-send \
            -u "$URGENCY" \
            -i "$ICON" \
            "Update$PLURAL available" \
            "$QTY new package$PLURAL"

        echo "$QTY update$PLURAL"  | tr '[:lower:]' '[:upper:]'

        sleep $LONG_SLEEP
    else
        echo

        sleep $SHORT_SLEEP
    fi
done
