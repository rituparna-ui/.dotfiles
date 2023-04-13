#!/bin/bash

# See README.md for usage instructions
bar_color="#b3cfa7"
volume_step=5
brightness_step=5
max_volume=100

# Uses regex to get volume from pactl
function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

# Uses regex to get mute status from pactl
function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

# Uses regex to get brightness from xbacklight
function get_brightness {
    light | grep -Po '[0-9]{1,3}' | head -n 1
}

function get_mic_status {
    pactl get-source-mute @DEFAULT_SOURCE@ | grep -Po '(?<=Mute: )(yes|no)'
}

# Returns a mute icon, a volume-low icon, or a volume-high icon, depending on the volume
function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ] ; then
        volume_icon=""
    elif [ "$volume" -lt 50 ]; then
        volume_icon=""
    else
        volume_icon=""
    fi
}

function get_mic_icon {
    mute=$(get_mic_status)
    if [ "$mute" == "yes" ] ; then
        mic_icon=""
    else
        mic_icon=""
    fi
}

# Always returns the same icon - I couldn't get the brightness-low icon to work with fontawesome
function get_brightness_icon {
    brightness_icon=""
}

# Displays a volume notification using dunstify
function show_volume_notif {
    volume=$(get_mute)
    get_volume_icon
    dunstify -i audio-volume-muted-blocking -t 1000 -r 2593 -u normal "$volume_icon $volume%" -h int:value:$volume -h string:hlcolor:$bar_color
}

# Displays a brightness notification using dunstify
function show_brightness_notif {
    brightness=$(get_brightness)
    get_brightness_icon
    dunstify -t 1000 -r 2593 -u normal "$brightness_icon $brightness%" -h int:value:$brightness -h string:hlcolor:$bar_color
}

function show_mic_notif {
    micmute=$(get_mic_status)
    get_mic_icon
    if [ "$micmute" == "no" ] ; then
        perc=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep -Po '\d{2}%' | head -n 1)
        dunstify -t 1000 -r 2593 -u normal "$mic_icon $perc" -h int:value:$perc -h string:hlcolor:$bar_color
    else
        dunstify -t 1000 -r 2593 -u normal "$mic_icon mute" 
    fi
    # -h int:value:$brightness -h string:hlcolor:$bar_color
}

# Main function - Takes user input, "volume_up", "volume_down", "brightness_up", or "brightness_down"
case $1 in
    volume_up)
    # Unmutes and increases volume, then displays the notification
    pactl set-sink-mute @DEFAULT_SINK@ 0
    volume=$(get_volume)
    if [ $(( "$volume" + "$volume_step" )) -gt $max_volume ]; then
        pactl set-sink-volume @DEFAULT_SINK@ $max_volume%
    else
        pactl set-sink-volume @DEFAULT_SINK@ +$volume_step%
    fi
    show_volume_notif
    ;;

    volume_down)
    # Raises volume and displays the notification
    pactl set-sink-volume @DEFAULT_SINK@ -$volume_step%
    show_volume_notif
    ;;

    volume_mute)
    # Toggles mute and displays the notification
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    show_volume_notif
    ;;

    brightness_up)
    # Increases brightness and displays the notification
    light -A $brightness_step
    show_brightness_notif
    ;;

    brightness_down)
    # Decreases brightness and displays the notification
    light -U $brightness_step
    show_brightness_notif
    ;;

    mic_toggle)
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    # show_brightness_notif
    show_mic_notif
    ;;
esac

