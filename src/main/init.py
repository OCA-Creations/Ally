import argparse
import os

class InitOptions:
    def __init__(self, no_zshrc=False, no_output=False, overwrite_dotfile=False):
        self.no_zshrc = no_zshrc
        self.no_output = no_output
        self.overwrite_dotfile = overwrite_dotfile

class AllyInit:
    def __init__(self, options):
        self.options = options

    def conditional_print(self, *args, separator=" ", end="\n"):
        if not self.options.no_output:
            print(separator.join(map(str, args)), end=end)

    def run(self):
        install_location = os.path.abspath(__file__)
        file_contents = f"alias ally={install_location}\n"
        file_location = os.path.expanduser("~/.ally")

        if os.path.exists(file_location):
            overwrite_file = input("[WARNING] Your .ally file exists. Do you want us to overwrite it? WARNING: THIS CANNOT BE UNDONE! (y/n): ")
            if overwrite_file == "y":
                self.write_ally_file(overwrite=True)
            else:
                self.bold_print("We are not overwriting your .ally file. Exiting now.")
                exit(1)
        else:
            with open(file_location, 'w') as f:
                f.write(file_contents)
            self.conditional_print("[SYSTEM] Created .ally file.")

        if not self.options.no_zshrc:
            zshrc_location = os.path.expanduser("~/.zshrc")
            try:
                with open(zshrc_location, 'r') as f:
                    current_zshrc_contents = f.read()
            except FileNotFoundError:
                current_zshrc_contents = None

            if current_zshrc_contents is not None:
                new_content = "\n#Put this wherever - it adds the aliases.\nsource $HOME/.ally\n"
                if new_content not in current_zshrc_contents:
                    current_zshrc_contents += new_content
                    with open(zshrc_location, 'w') as f:
                        f.write(current_zshrc_contents)
            else:
                self.conditional_print("[WARNING] No .zshrc found.")
        else:
            self.conditional_print("[SYSTEM] Not adding to ZSHRC.")

        self.conditional_print("""
[SYSTEM] .zshrc and .ally files are set up.
To reload your current shell session, execute the following command:
source $HOME/.ally
""")

    def write_ally_file(self, overwrite):
        pass

    def bold_print(self, content, end="\n"):
        print(f"\033[1m{content}\033[0m", end=end)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Initialize and install ally.")
    parser.add_argument("--no-zshrc", "-z", action="store_true", help="Don't add the source block to the end of .zshrc.")
    parser.add_argument("--no-output", "-n", action="store_true", help="Produce no output when installing the tool.")
    parser.add_argument("--overwrite-dotfile", "-o", action="store_true", help="Overwrite the .ally file on install.")
    args = parser.parse_args()

    options = InitOptions(no_zshrc=args.no_zshrc, no_output=args.no_output, overwrite_dotfile=args.overwrite_dotfile)
    ally_init = AllyInit(options)
    ally_init.run()
