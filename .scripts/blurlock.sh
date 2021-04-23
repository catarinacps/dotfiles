#!/usr/bin/env bash

# crash before doing stupid stuff
set -euo pipefail

# where to store the temporary image
TMP_IMG="/tmp/screenshot.png"

# big line, I know, but this gets all the xresources colors in a nice array
COLORS=($(xrdb -q | grep 'color' | sort -V | cut -d# -f2 | xargs))

# set the parameters for i3lock-colors
PARAMS=(--insidecolor="${COLORS[0]}66" \
        --ringcolor="${COLORS[7]}4e" \
        --linecolor="${COLORS[1]}ff" \
        --keyhlcolor="${COLORS[1]}ff" \
        --ringvercolor="${COLORS[7]}00" \
        --verifcolor="${COLORS[0]}00" \
        --separatorcolor="${COLORS[8]}60" \
        --insidevercolor="${COLORS[7]}00" \
        --ringwrongcolor="${COLORS[7]}55" \
        --insidewrongcolor="${COLORS[7]}1c" \
        --force-clock \
        --datestr='%A' \
        --timestr='%H:%M' \
        --timecolor="${COLORS[7]}ff" \
        --datecolor="${COLORS[7]}ff" \
        --indicator \
        --pass-media-keys)

# take screenshot of the whole screen
import -window root $TMP_IMG

# blur it
convert $TMP_IMG -blur 0x5 $TMP_IMG

# lock the screen
i3lock ${PARAMS[@]} -i $TMP_IMG -n

# wait a bit before going because race conditions
sleep 1
