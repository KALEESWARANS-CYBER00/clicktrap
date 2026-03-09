import os
import platform
import subprocess

system = platform.system()

if system == "Linux":
    subprocess.run(["xdg-open","assets/photo.jpeg"])
    subprocess.run(["python3","awareness.py"])

elif system == "Windows":
    os.startfile("assets\\photo.jpeg")
    subprocess.run(["python","awareness.py"])
