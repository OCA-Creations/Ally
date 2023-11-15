# This script installs the Ally tool and is likely used via CuRL from the server in a one-liner
# First off, clone the repo and use `swift build` to build ally
echo "[ALLY-SYSTEM]: Welcome to Ally! Ally is a simple, lightweight tool to work with ZSH aliases. It uses pure sh code, so there is no vendor lock-in. This script will explain what it does and ask for permission before doing so."
echo "[ALLY-SYSTEM] This install script will now clone the Git Repo from GitHub in order to build Ally. Install git from https://git-scm.com if you do not have it installed."
ask_for_continue() {
    read -p "[PERMISSION] Continue? (y/n) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        return
    fi
    exit 1

}

ask_for_continue
git clone https://github.com/OCA-Creations/Ally.git
cd Ally
echo "[ALLY-SYSTEM] The script will now build the CLI tool."
ask_for_continue
swift build -c release --build-path ~/ally
# Then, move the binary to /usr/local/bin
echo "[ALLY_SYSTEM] The next step requires sudo access in order to move the built binary to your bin. It will only move the built ally binary."
ask_for_continue
sudo mv ~/ally/release/ally /usr/local/bin
# Then, remove the build folder
rm -rf ~/ally
# Then, remove the repo
cd ..
rm -rf Ally
echo "[ALLY-SYSTEM] Ally is now installed, and all superflous directories created in install are cleaned up!"
read -p "Would you like to initialize Ally? (y/n) "
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    return
fi
    exit 1
# Now, run `ally init`
/usr/local/bin/ally init
# Finally, ally is now installed and ready to use!
echo "Ally is now installed and ready to use! You need to reload your terminal to use it:"
echo -e "\033[1msource ~/.zshrc\033[0m"
