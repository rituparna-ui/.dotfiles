import tkinter as tk
from tkinter import ttk, colorchooser

import os
# root window
root = tk.Tk()
root.geometry('300x400')
root.resizable(False, False)
root.title('Keyboard Backlight')

stat_button = ttk.Button(
    root,
    text='Static',
    command=lambda: os.system(
        'echo "1 0 0 128 128 2" > /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode'
    ))

bret_button = ttk.Button(
    root,
    text="Breathe",
    command=lambda: os.system(
        'echo "1 1 0 128 128 2" > /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode'
    ))

cycl_button = ttk.Button(
    root,
    text="Cycle",
    command=lambda: os.system(
        'echo "1 2 0 128 128 2" > /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode'
    ))

strk_button = ttk.Button(
    root,
    text="Stroke",
    command=lambda: os.system(
        'echo "1 9 0 128 128 2" > /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode'
    ))


def choose_color():
    color = colorchooser.askcolor(title="Pick Backlight Color")
    os.system(
        f'echo "1 0 {color[0][0]} {color[0][1]} {color[0][2]} 2" > /sys/class/leds/asus::kbd_backlight/kbd_rgb_mode'
    )


clrp_button = ttk.Button(root, text="Color Picker", command=choose_color)


def change_brightness(event):
    os.system(
        f'echo "{int(brig_slider.get())}" > /sys/class/leds/asus::kbd_backlight/brightness'
    )


brig_slider = ttk.Scale(root,
                        from_=0,
                        to=3,
                        orient='horizontal',
                        command=change_brightness)

quit_button = ttk.Button(root, text="Quit", command=lambda: root.quit())

stat_button.pack(ipadx=5, ipady=5, expand=True)
bret_button.pack(ipadx=5, ipady=5, expand=True)
cycl_button.pack(ipadx=5, ipady=5, expand=True)
strk_button.pack(ipadx=5, ipady=5, expand=True)
clrp_button.pack(ipadx=5, ipady=5, expand=True)
brig_slider.pack(ipadx=5, ipady=5, expand=True)
quit_button.pack(ipadx=5, ipady=5, expand=True)

root.mainloop()
