import tkinter as tk

msg = """
YOU HAVE BEEN HACKED

This was a Cyber Security Awareness Test.

You opened a file that looked like a normal image.

Attackers often disguise malicious files as photos.

Always verify unknown files before opening them.
"""

root = tk.Tk()
root.attributes("-fullscreen", True)
root.configure(bg="black")

title = tk.Label(root,text="SECURITY BREACH DETECTED",
fg="red",bg="black",font=("Arial",40,"bold"))

title.pack(pady=40)

text = tk.Label(root,text=msg,
fg="white",bg="black",font=("Arial",20),justify="center")

text.pack()

def close(event=None):
    root.destroy()

root.bind("<Escape>",close)

root.mainloop()
