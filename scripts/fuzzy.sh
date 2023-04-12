#!/bin/sh -e

rm -f /tmp/screen_locked.png

# Take a screenshot
scrot /tmp/screen_locked.png

# Pixellate it 10x
mogrify -scale 25% -scale 400% /tmp/screen_locked.png

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png

# Optionally suspend.
if [ "$1" == "suspend" ]; then
  systemctl suspend
fi

