#!/bin/zsh

# This script installs the Ally tool and is likely used via CuRL from the server in a one-liner

function ask_for_continue() {
    read -n 1 -r -p "[PERMISSION] Continue? (y/n) "
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "Continuing..."
    else
        exit 1
    fi
}

echo "[ALLY-SYSTEM]: Welcome to Ally! Ally is a simple, lightweight tool to work with ZSH aliases. It uses pure sh code, so there is no vendor lock-in. This script will explain what it does and ask for permission before doing so."
echo "[ALLY-SYSTEM] This install script will now clone the Git Repo from GitHub in order to build Ally. Install git from https://git-scm.com if you do not have it installed."

ask_for_continue
git clone https://github.com/OCA-Creations/Ally.git
cd Ally
echo "[ALLY-SYSTEM] The script will now build the CLI tool."
ask_for_continue
swift build -c release --build-path ~/ally
# Then, move the binary to /usr/local/bin and rename it to _ally
echo "[ALLY_SYSTEM] The next step requires sudo access in order to move the built binary to your bin and rename it to _ally. It will only move the built ally binary."
ask_for_continue
sudo mv ~/ally/release/ally /usr/local/bin/_ally
# Then, remove the build folder
rm -rf ~/ally
# Then, remove the repo
cd ..
rm -rf Ally
echo "[ALLY-SYSTEM] Ally is now installed as _ally, and all superfluous directories created in install are cleaned up!"

read -n 1 -r -p "Initialize Ally? (y/n) "
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Initializing..."
else
    exit 1
fi

# Now, run `ally init`
/usr/local/bin/_ally init

# Add the function specified in `function.sh` to .zshrc
echo "Adding Ally function to .zshrc for automatic terminal reload..."
cat <<EOF >> ~/.zshrc
function ally {
    # We will be reloading by default
    IFS=$'\n'
    ARGS=\$@
    _ally \$ARGS
    source ~/.ally
}
EOF

# Finally, ally is now installed and ready to use!
echo "Ally is now installed and ready to use! You need to reload your terminal to use it:"
echo -e "\033[1msource ~/.zshrc\033[0m"
