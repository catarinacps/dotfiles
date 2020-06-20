#!/bin/sh

# a simple watcher script that tries to be smart about sxhkd chords

# exits on failures
set -euf

FIFO_PIPE="$1"

# no pipe, no game
[ -p "$FIFO_PIPE" ] || exit 1

CONFIG_FILE="$HOME/.config/sxhkd/sxhkdrc"

NAMES_FILE="$(mktemp)"
KEYBINDINGS_FILE="$(mktemp)"
PAIRS_FILE="$(mktemp)"

# quit if sxhkd isn't running
pgrep -x sxhkd > /dev/null || exit 1

# collect all names from the annotations
grep '#+chord:' "$CONFIG_FILE" | cut -d ' ' -f2- > "$NAMES_FILE"

# collect the actual keys that follow said annotations
sed -n '/#+chord:/{n; p;}' "$CONFIG_FILE" \
    | tr -d ' ' | tr ';' ':' | cut -d ':' -f1 > "$KEYBINDINGS_FILE"

# paste them together
paste -d ' ' "$NAMES_FILE" "$KEYBINDINGS_FILE" > "$PAIRS_FILE"

# clean up the now useless temps
rm -f "$NAMES_FILE" "$KEYBINDINGS_FILE"

# while we read events
cat "$FIFO_PIPE" | while read line; do
    # check what kind of event happened
    case "$line" in
        H*)
            # clean out the keypress
            clean=$(echo "$line" | tr -d ' ' | cut -c2-)

            # test all pairs always
            while read -r name key; do
                # if we found our match, lets put it in the bar
                [ "$clean" = "$key" ] && i3-msg mode "$name" && break
            done < "$PAIRS_FILE"
            ;;
        EEnd*)
            # if we are ending a chain, back to the default mode
            i3-msg mode 'default'
            ;;
    esac
done
