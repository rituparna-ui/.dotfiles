import tkinter as tk
from tkinter import ttk
import os
# root window
root = tk.Tk()
root.geometry('300x300')
root.resizable(False, False)
root.title('PowerMenu')

# exit button
exit_button = ttk.Button(root,text='Logout',command=lambda: os.system("i3-msg exit"))
shut_button = ttk.Button(root,text="Poweroff",command=lambda: os.system("systemctl poweroff"))
rebo_button = ttk.Button(root,text="Reboot",command=lambda: os.system("systemctl poweroff"))
lock_button = ttk.Button(root,text="Lock",command=lambda: os.system("exec ~/scripts/fuzzy.sh"))
quit_button = ttk.Button(root,text="Quit",command=lambda: root.quit())

exit_button.pack(ipadx=5,ipady=5,expand=True)
shut_button.pack(ipadx=5,ipady=5,expand=True)
rebo_button.pack(ipadx=5,ipady=5,expand=True)
lock_button.pack(ipadx=5,ipady=5,expand=True)
quit_button.pack(ipadx=5,ipady=5,expand=True)

root.mainloop()
