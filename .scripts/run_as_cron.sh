#!/bin/sh

. "$1"
exec env -i "$SHELL" -c ". $1; $2"
