#!/usr/bin/env bash

## control_services.sh
#
# Copyright: (C) 2021 Henrique Silva
#
# Author: Henrique Silva <hcpsilva@inf.ufrgs.br>
#
# License: GNU General Public License version 3, or any later version
#
# This program is  free software; you can redistribute  it and/or modify
# it under the  terms of the GNU General Public  License as published by
# the Free Software Foundation, either version  3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
## Commentary:
#
# Receives a systemctl command as an argument, lists the current
# installed unit files as options and reads the user choice between
# these options. After that, executes the command and sends a
# notification of the executed command in case of success.
#
## Code:

# use lastpipe to improve readability
shopt -s lastpipe

# possible options
OPTIONS='start stop restart reload'

# check if arg is one of the options. if not, quit with error code 1
grep -qw "$1" <<<"$OPTIONS" || exit 1

ACTION="$1"

# reads unit file list and assigns it to the variable `SERVICES`
systemctl --user list-unit-files |
    grep -v 'static\|generated\|alias' |
    awk '/service/ {print $1}' |
    read -r -d '' SERVICES

# shows to  the user the options  through rofi and assign  the answer to
# the variable `CHOICE`
rofi -dmenu -p unit -i -mesg "Select the unit you wish to $ACTION" <<<"$SERVICES" |
    read -r CHOICE

# if choice is empty (no selection made), exit
[ "$CHOICE" = '' ] && exit 0

# executes action  and sends a  notification of  it if it  succeeded. if
# not, quit with error code 2
systemctl --user "$ACTION" "$CHOICE" || exit 2
notify-send "$ACTION" "$CHOICE"

## control_services.sh ends here
