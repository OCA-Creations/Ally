import argparse
import os

class Uninstall:
    def __init__(self):
        self.parser = argparse.ArgumentParser(description="Uninstall Ally")
        self.parser.add_argument('--no-output', action='store_true', help="Produce no output while uninstalling Ally.")
        self.parser.add_argument('--remove-dotfile', action='store_true', help="Remove the .ally file during uninstallation.")
        self.args = self.parser.parse_args()

    def run(self):
        if not self.args.no_output:
            print("Uninstalling Ally...")

        # Remove the ally binary
        try:
            os.remove('/usr/local/bin/ally')
            if not self.args.no_output:
                print("Removed ally binary from /usr/local/bin/ally")
        except FileNotFoundError:
            if not self.args.no_output:
                print("Ally binary not found at /usr/local/bin/ally")

        # Optionally remove the .ally file
        if self.args.remove_dotfile:
            try:
                os.remove(os.path.expanduser('~/.ally'))
                if not self.args.no_output:
                    print("Removed .ally file from home directory")
            except FileNotFoundError:
                if not self.args.no_output:
                    print(".ally file not found in home directory")

        if not self.args.no_output:
            print("Ally has been uninstalled.")

if __name__ == "__main__":
    Uninstall().run()
