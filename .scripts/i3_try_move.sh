#!/bin/sh

# just because sometimes i3 doesn't like to move or focus

i3-msg $1 $2 || i3-msg $1 output $2
