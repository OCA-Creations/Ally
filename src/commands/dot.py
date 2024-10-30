import argparse
import os
import subprocess

class Dot:
    def __init__(self):
        self.parser = argparse.ArgumentParser(description="Work with Ally's dotfile (the .ally file).")
        subparsers = self.parser.add_subparsers(dest='command')

        open_parser = subparsers.add_parser('open', help='Open the .ally file.')
        open_parser.add_argument('--location', type=str, default=self.dot_file_location(), help='The location of the .ally file.')
        open_parser.add_argument('--editor', type=str, help='The app/executable with which to open the .ally file. Default: system default text editor.')

        format_parser = subparsers.add_parser('format', help='Format the .ally file.')

    def dot_file_location(self):
        return os.path.expanduser("~/.ally")

    def validate(self, location):
        if not os.path.exists(location):
            raise ValueError(f"File does not exist at {location}")

    def open_file(self, file_path, editor=None):
        if editor:
            subprocess.run(["open", file_path, "-a", editor])
        else:
            subprocess.run(["open", file_path])

    def run(self):
        args = self.parser.parse_args()
        if args.command == 'open':
            self.validate(args.location)
            self.open_file(args.location, args.editor)
        elif args.command == 'format':
            # TODO: Implement formatting of .ally file
            pass

if __name__ == "__main__":
    dot = Dot()
    dot.run()
