import os
import ctypes
import platform
import requests

def set_wallpaper(image_path):
    system = platform.system()

    if system == "Windows":
        # For Windows
        ctypes.windll.user32.SystemParametersInfoW(20, 0, image_path, 3)
    elif system == "Darwin":
        # For macOS
        os.system(f"osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"{image_path}\"'")
    elif system == "Linux":
        # Common GNOME desktop environment
        os.system(f"gsettings set org.gnome.desktop.background picture-uri 'file://{image_path}'")
    else:
        print("Unsupported OS")

def get_random_image():
    url = "https://picsum.photos/1920/1080"  # Random 1080p image
    response = requests.get(url, stream=True)
    file_path = os.path.join(os.path.expanduser("~"), "random_wallpaper.jpg")

    with open(file_path, "wb") as f:
        for chunk in response.iter_content(1024):
            f.write(chunk)

    return file_path

if __name__ == "__main__":
    img = get_random_image()
    set_wallpaper(img)
    print(f"Wallpaper set to {img}")
