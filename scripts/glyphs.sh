#!/bin/bash
read -r code < <(rofi -dmenu -i -no-fixed-num-lines -p "CODE: " -theme ~/.config/rofi/code.rasi)
echo -ne "\U$code" | xclip -selection c
