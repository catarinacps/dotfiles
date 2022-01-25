#!/bin/sh

# simple screenshot-script using scrot for manjaro-i3 by oberon@manjaro.org
# modified by me! @hcpsilva

DEFAULT_DIR="$HOME/Pictures"

usage() {
    cat <<EOF
USAGE:
  $0 [OPTIONS] [directory]

WHERE [OPTIONS] are:
  -d | --desk    full screen
  -w | --window  active window
  -s | --select  selection
  -h | --help    display this information

Default option is 'full screen'.

Default directory to save the images is $DEFAULT_DIR
EOF
}

scrot_dir=${2:-$DEFAULT_DIR}

[ ! -d "$scrot_dir" ] && mkdir -p "$scrot_dir"

for i in "$@"; do
    case $i in
        --desk|-d)
            cd "$scrot_dir"
            scrot &&
                notify-send "full-screen screenshot has been saved in $scrot_dir"
            ;;
        --window|-w)
            cd "$scrot_dir"
            scrot -u &&
                notify-send "window screenshot has been saved in $scrot_dir"
            ;;
        --select|-s)
            cd "$scrot_dir"
            scrot -fs &&
                notify-send "region screenshot has been saved in $scrot_dir"
            ;;
        --help|-h)
            usage
            ;;
        *)
            echo "ERROR: Unknown argument '$i'"
            echo
            usage
            exit 2
            ;;
    esac
done

exit 0
