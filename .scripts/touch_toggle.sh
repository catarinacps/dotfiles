#!/usr/bin/env bash

#
# touch_toggle
#
# Toggle the touchpad on/off.

set -euo pipefail

[ "${1:-}" = '-v' ] && VERBOSE='true' || VERBOSE='false'

# Get the id number of the touchpad.
tp_id=$(xinput list | grep -i touchpad | awk '{print $6}' | sed 's/id=//')


# Find out whether the touchpad is enabled or not.
tp_enabled=$(xinput list-props $tp_id | grep Device\ Enabled | awk '{print $4}')


if [ $tp_enabled = 0 ]; then
    # The touchpad is currently disabled, so turn it on.
    xinput set-prop $tp_id "Device Enabled" 1
    [ $VERBOSE = 'true' ] && echo "INFO [touch_toggle.sh]: Touchpad now on"
elif [ $tp_enabled = 1 ]; then
    # The touchpad is currently enabled, so turn it off.
    xinput set-prop $tp_id "Device Enabled" 0
    [ $VERBOSE = 'true' ] && echo "INFO [touch_toggle.sh]: Touchpad now off"
else
    echo "ERROR [touch_toggle.sh]: Could not get touchpad status from xinput" 1>&2
    exit 1
fi
