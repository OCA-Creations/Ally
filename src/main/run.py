import argparse
import os

class Ally:
    def __init__(self):
        self.parser = argparse.ArgumentParser(
            description="A utility for managing ZSH aliases."
        )
        self.subparsers = self.parser.add_subparsers(dest="command")

        self.dot_file_location = os.path.join(os.path.expanduser("~"), ".ally")
        self.zshrc_file_location = os.path.join(os.path.expanduser("~"), ".zshrc")

    def run(self):
        args = self.parser.parse_args()
        if args.command is None:
            self.parser.print_help()

if __name__ == "__main__":
    ally = Ally()
    ally.run()
