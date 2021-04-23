#!/usr/bin/env bash

# made by @hcpsilva, feel free to use in any way you wish

# prints the network if name and its current chosen IP if not disconnected
print_info() {
    if [ "$name" ]; then
        echo "${name}: ${!current} (${current%[0-9]})"
    else
        echo 'DISCONNECTED'
    fi
}

# listens to the pipe waiting updates or the toggle view command
stdio_writer() {
    current='lan4'

    while IFS=',' read -r id tl4 tw4 tl6 tw6; do
        case "$id" in
            (!*)
                name="${id#\!}"
                lan4="$tl4"
                lan6="$tl6"
                wan4="$tw4"
                wan6="$tw6"
                ;;
            (c)
                current=$(echo "$current" | tr '46' '64')
                ;;
            (t)
                current=$(echo "$current" | tr 'wl' 'lw')
                ;;
            (d)
                name=''
                ;;
            (*)
                echo "ERROR: Input '$id' is not recognized" >&2
                ;;
        esac

        print_info
    done <"$NETWORK_PIPE"
}

# initializes constants
NETWORK_PIPE='/tmp/polybar_network.fifo'
QUERY_DOMAIN='o-o.myaddr.l.google.com'
QUERY_NS='@ns1.google.com'
SHORT_SLEEP=10
LONG_SLEEP=$((SHORT_SLEEP * 20))

# if necessary, remove and then create the FIFO
[ -p "$NETWORK_PIPE" ] && rm -f "$NETWORK_PIPE"

mkfifo "$NETWORK_PIPE"

# sends the writer process to listen to the pipe in the background
stdio_writer &

# open up fd3 to point to the pipe
exec 3>$NETWORK_PIPE

# updating loop
while true; do
    IFNAME="$(ip -o link | awk '/state UP/ {print $2}' | tr -d ':')"

    if [ "$IFNAME" ]; then
        WAN6=$(dig -6 TXT +short "$QUERY_DOMAIN" "$QUERY_NS" | tr -d '"')
        LAN6=$(ip -o -6 addr show dev "$IFNAME" scope link | awk '{print $4; exit}')
        WAN4=$(dig -4 TXT +short "$QUERY_DOMAIN" "$QUERY_NS" | tr -d '"')
        LAN4=$(ip -o -4 addr show dev "$IFNAME" scope global | awk '{print $4; exit}')

        SSID="$(iwgetid -r)"; [ "$SSID" ] && IFNAME="$IFNAME ($SSID)"

        echo "!${IFNAME},${LAN4:-NA},${WAN4:-NA},${LAN6:-NA},${WAN6:-NA}" |
            sed -E 's/\/[0-9]+(,?)/\1/g' >&3

        [ "$WAN4" != '' ] && sleep $LONG_SLEEP
    else
        echo 'd' >&3

        sleep $SHORT_SLEEP
    fi
done

# closes fd3 (this code wont be reached)
exec 3>&-
