# This script installs the Ally tool and is likely used via CuRL from the server in a one-liner
# First off, clone the repo and use `swift build` to build ally
git clone https://github.com/OCA-Creations/Ally.git
cd Ally
swift build -c release --build-path ~/ally
# Then, move the binary to /usr/local/bin
sudo mv ~/ally/release/ally /usr/local/bin
# Then, remove the build folder
rm -rf ~/ally
# Then, remove the repo
cd ..
rm -rf Ally
# Now, run `ally init`
/usr/local/bin/ally init
# Finally, ally is now installed and ready to use!
echo "Ally is now installed and ready to use! You need to reload your terminal to use it:"
echo -e "\033[1msource ~/.zshrc\033[0m"
