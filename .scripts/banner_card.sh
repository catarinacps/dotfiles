#!/bin/bash

## banner_card.sh
#
# Copyright: (C) 2021 Henrique Silva
#
# Author: Henrique Silva <hcpsilva@inf.ufrgs.br>
#
# License: GNU General Public License version 3, or any later version
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
## Commentary:
#
# Takes  a line  from the  default 'nice  thoughts' file  and prints  it
# nicely.
#
## Code:

SENTENCES_FILE="$HOME/OneDrive/documentos/enfrentamento.txt"

LINE_COUNT=$(wc -l < "$SENTENCES_FILE")

sed "$((1 + RANDOM % LINE_COUNT))q;d" "$SENTENCES_FILE" | \
    figlet -f slant -c -C utf8 | \
    lolcat
echo

## banner_card.sh ends here
