#!/usr/bin/env python3
import os
import subprocess

def ask_for_continue():
    response = input("[PERMISSION] Continue? (y/n) ")
    if response.lower() == 'y':
        print("Continuing...")
    else:
        exit(1)

# This script installs the Ally tool and is likely used via CuRL from the server in a one-liner
print("[ALLY-SYSTEM]: Welcome to Ally! Ally is a simple, lightweight tool to work with ZSH aliases. It uses pure Python code, so there is no vendor lock-in. This script will explain what it does and ask for permission before doing so.")
print("[ALLY-SYSTEM] This install script will now clone the Git Repo from GitHub in order to build Ally. Install git from https://git-scm.com if you do not have it installed.")

ask_for_continue()
subprocess.run(["git", "clone", "https://github.com/OCA-Creations/Ally.git"])
os.chdir("Ally")
print("[ALLY-SYSTEM] The script will now build the CLI tool.")
ask_for_continue()
subprocess.run(["swift", "build", "-c", "release", "--build-path", os.path.expanduser("~/ally")])
# Then, move the binary to /usr/local/bin
print("[ALLY_SYSTEM] The next step requires sudo access in order to move the built binary to your bin. It will only move the built ally binary.")
ask_for_continue()
subprocess.run(["sudo", "mv", os.path.expanduser("~/ally/release/ally"), "/usr/local/bin/ally"])
# Then, remove the build folder
subprocess.run(["rm", "-rf", os.path.expanduser("~/ally")])
# Then, remove the repo
os.chdir("..")
subprocess.run(["rm", "-rf", "Ally"])
print("[ALLY-SYSTEM] Ally is now installed, and all superfluous directories created in install are cleaned up!")
response = input("Initialize Ally? (y/n) ")
if response.lower() == 'y':
    print("Initializing...")
else:
    exit(1)
# Now, run `ally init`
subprocess.run(["/usr/local/bin/ally", "init"])
# Finally, ally is now installed and ready to use!
print("Ally is now installed and ready to use! You need to reload your terminal to use it:")
print("\033[1msource ~/.zshrc\033[0m")
