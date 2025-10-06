import os
import ctypes
import platform
import requests
import random
import tempfile
from playsound import playsound

def set_wallpaper(image_path):
    system = platform.system()
    if system == "Windows":
        ctypes.windll.user32.SystemParametersInfoW(20, 0, image_path, 3)
    elif system == "Darwin":
        os.system(f"osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"{image_path}\"'")
    elif system == "Linux":
        os.system(f"gsettings set org.gnome.desktop.background picture-uri 'file://{image_path}'")
    else:
        print("Unsupported OS")

def get_random_image():
    url = "https://picsum.photos/1920/1080"
    response = requests.get(url, stream=True)
    file_path = os.path.join(os.path.expanduser("~"), "random_wallpaper.jpg")

    with open(file_path, "wb") as f:
        for chunk in response.iter_content(1024):
            f.write(chunk)

    return file_path

def play_random_audio():
    # Some sample royalty-free audio files (short effects)
    audio_urls = [
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3"
    ]

    url = random.choice(audio_urls)
    print(f"Downloading audio: {url}")

    r = requests.get(url, stream=True)
    tmpfile = tempfile.NamedTemporaryFile(delete=False, suffix=".mp3")
    for chunk in r.iter_content(1024):
        tmpfile.write(chunk)
    tmpfile.close()

    print("Playing sound...")
    playsound(tmpfile.name)

if __name__ == "__main__":
    img = get_random_image()
    set_wallpaper(img)
    play_random_audio()
    print(f"Wallpaper set to {img}")
