#!/bin/sh -e

rm -f /tmp/screen_locked.png

# Take a screenshot
scrot /tmp/screen_locked.png

# Pixellate it 20x
# mogrify -scale 25% -scale 400% /tmp/screen_locked.png
mogrify -scale 6.25% -scale 1600% /tmp/screen_locked.png

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png

# Optionally suspend.
if [ "$1" == "suspend" ]; then
  systemctl suspend
fi

