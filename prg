import os
import requests
import sys

def add_to_startup():
    """Add this script to the Windows Startup folder."""
    startup_dir = os.path.join(
        os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup"
    )
    script_path = os.path.abspath(__file__)
    bat_path = os.path.join(startup_dir, "my_startup_launcher.bat")

    # Create a .bat file that runs this Python script
    with open(bat_path, "w") as bat_file:
        bat_file.write(f'@echo off\npython "{script_path}"\n')

    print(f"Added to startup: {bat_path}")

def run_remote_code(url):
    """Download and run Python code from a URL (e.g., GitHub raw)."""
    try:
        response = requests.get(url)
        response.raise_for_status()
        code = response.text
        print(f"Running remote code from {url}...\n")
        exec(code, globals())  # executes fetched code
    except Exception as e:
        print("Error fetching or running remote code:", e)

if __name__ == "__main__":
    # Install itself into startup if not already there
    add_to_startup()

    # Example: fetch your GitHub-hosted script
    github_url = "https://raw.githubusercontent.com/your-username/your-repo/main/script.py"
    run_remote_code(github_url)
