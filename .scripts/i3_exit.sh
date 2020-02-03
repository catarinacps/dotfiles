#!/bin/sh

# with openrc use loginctl
[ $(cat /proc/1/comm) = "systemd" ] && logind=systemctl || logind=loginctl

choice=$(echo "lock logout switch_user suspend hibernate reboot shutdown" | \
             sed 's/ /\n/g' | \
             rofi -dmenu -width 15 -lines 7)

case "$choice" in
    lock)
        blurlock.sh
        ;;
    logout)
        i3-msg exit
        ;;
    switch_user)
        dm-tool switch-to-greeter
        ;;
    suspend)
        blurlock.sh && $logind suspend
        ;;
    hibernate)
        blurlock.sh && $logind hibernate
        ;;
    reboot)
        $logind reboot
        ;;
    shutdown)
        $logind poweroff
        ;;
    *)
        notify-send -u normal "ERROR" "invalid choice for i3_exit.sh"
        exit 2
esac

exit 0
