import argparse
import os
import subprocess

class AddOptions:
    def __init__(self):
        parser = argparse.ArgumentParser(description="Add an alias to the zsh config.")
        parser.add_argument("alias", help="The alias to be added. This is the command that will be given in the future, not the longform version being aliased to.")
        parser.add_argument("command", nargs='?', help="The long-form command to be aliased to `alias`.")
        parser.add_argument("--description", help="Description/title of the alias, to be put on the preceding line in the file.")
        parser.add_argument("--reload", action="store_true", help="Reload the terminal (a.k.a run \u001b[1msource\u001b[0m) after adding the alias.")
        parser.add_argument("--no-output", action="store_true", help="Produce no output.")
        self.args = parser.parse_args()

class AllyAdd:
    def __init__(self):
        self.options = AddOptions().args

    def conditional_print(self, message):
        if not self.options.no_output:
            print(message)

    def run(self):
        if "=" in self.options.alias:
            new_opts = self.options.alias.split("=", 1)
            self.options.alias = new_opts[0]
            self.options.command = new_opts[1]

        if self.options.command:
            dot_file_location = os.path.expanduser("~/.ally")
            if not os.path.exists(dot_file_location):
                yes_or_no = input("[SYSTEM] Ally has not yet been installed, would you like to install it? (y/n)")
                if yes_or_no != "y":
                    return
                try:
                    subprocess.run(["ally", "init", "--no-output"], check=True)
                    self.conditional_print("[SYSTEM] Ally has been installed and initialized.")
                except subprocess.CalledProcessError as e:
                    self.conditional_print(f"There was an error installing ally: {e}. Exiting now.")
                    return

            alias_line = f'\nalias {self.options.alias}="{self.options.command}"\n'
            if self.options.description:
                alias_line = f'\n# {self.options.description}\n{alias_line}'

            try:
                with open(dot_file_location, "a") as file:
                    file_contents = file.read()
                    if f"alias {self.options.alias}=" not in file_contents:
                        file.write(alias_line)
                    else:
                        self.conditional_print(f"[WARNING] alias \u001b[1m{self.options.alias}\u001b[0m ALREADY EXISTS. Skipping.")
            except Exception as e:
                self.conditional_print(f"[ERROR] Saving alias to disk: {e}")

            if self.options.reload:
                self.conditional_print("Shell reloaded.")
            else:
                self.conditional_print("[NOTE]: Shell may require reload.")
        else:
            print(f"[ERROR] No value provided to alias '\u001b[1m{self.options.alias}\u001b[0m' TO. Please provide a long-form command to set the alias to.")

if __name__ == "__main__":
    AllyAdd().run()
