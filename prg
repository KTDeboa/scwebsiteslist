import os
import subprocess
import time
import pyautogui

# Get the current desktop username
username = os.getlogin()

# Open Notepad
subprocess.Popen(["notepad.exe"])

# Wait for Notepad to open
time.sleep(2)

# Type the username into Notepad
pyautogui.typewrite(f"Desktop Username: {username}", interval=0.05)
