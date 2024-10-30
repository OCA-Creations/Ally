import argparse
import os

class RemoveOptions:
    def __init__(self):
        parser = argparse.ArgumentParser(description="Remove an alias from the Ally/ZSH config.")
        parser.add_argument('-o', '--no-output', action='store_true', help="Produce no output while removing aliases.")
        parser.add_argument('--reload', action='store_true', help="Reload the shell after removing the alias.")
        parser.add_argument('alias', nargs='+', help="The aliases to remove from the .ally file.")
        parser.add_argument('--zshrc', action='store_true', help="Scan the .zshrc file for the aliases AS WELL AS the .ally file.")
        self.args = parser.parse_args()

class AllyRemove:
    def __init__(self):
        self.options = RemoveOptions().args

    def run(self):
        for alias in self.options.alias:
            self.scan_and_remove_if_needed(alias, self.dot_file_location(), not self.options.no_output)
            if self.options.zshrc:
                self.scan_and_remove_if_needed(alias, self.zshrc_file_location(), not self.options.no_output)

    def scan_and_remove_if_needed(self, alias, file_location, conditional_output):
        with open(file_location, 'r') as file:
            lines = file.readlines()

        finder = f"alias {alias}"
        new_lines = []
        skip_next = False

        for line in lines:
            if skip_next:
                skip_next = False
                continue
            if finder in line:
                if conditional_output:
                    print(f"Alias removed from {os.path.basename(file_location)}: {alias}")
                continue
            if line.strip().startswith("#") and new_lines and new_lines[-1].strip().startswith(finder):
                skip_next = True
                continue
            new_lines.append(line)

        with open(file_location, 'w') as file:
            file.writelines(new_lines)

        if conditional_output:
            print(f"Dot Ally file resaved. Alias {alias} no longer available.")
            print("[WARNING] Terminal may require reload.")

    @staticmethod
    def dot_file_location():
        return os.path.expanduser("~/.ally")

    @staticmethod
    def zshrc_file_location():
        return os.path.expanduser("~/.zshrc")

if __name__ == "__main__":
    AllyRemove().run()
