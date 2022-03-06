#!/bin/sh

SHORT_SLEEP=600
LONG_SLEEP=$((SHORT_SLEEP * 3))

while true; do
    UPDATES=$(checkupdates 2>/dev/null)

    QTY=$(printf '%s\n' "$UPDATES" | wc -l)

    [ "$QTY" -gt 1 ] && PLURAL='S'

    echo "$QTY UPDATE$PLURAL"

    sleep $LONG_SLEEP
done
