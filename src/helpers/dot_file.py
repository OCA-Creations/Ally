import os

class DotFile:
    def __init__(self, location):
        self.location = location
        self.aliases = []

    def output(self, docs):
        print("You have ", end="")
        self.bold_print(f"{len(self.aliases)}", end=" ")
        print("aliases added in Ally.")
        for alias in self.aliases:
            if docs and alias.docs:
                self.bold_print(alias.docs)
            self.bold_print(f"{alias.alias_name}", end=" -> ")
            print(alias.long_form_command)

    @staticmethod
    def bold_print(text, end="\n"):
        print(f"\033[1m{text}\033[0m", end=end)

    class Alias:
        def __init__(self, docs=None, alias_name="", long_form_command=""):
            self.docs = docs
            self.alias_name = alias_name
            self.long_form_command = long_form_command

    @staticmethod
    def parse_ally_file(file_location):
        def parse_already_docs(already_docs, index, lines):
            returnable = []
            if index > len(lines) - 1:
                return returnable
            current_line = lines[index]
            if current_line.strip().startswith("#"):
                al_docs = already_docs + "\n" + current_line
                returnable += parse_already_docs(al_docs, index + 1, lines)
            else:
                parts = current_line.split("=")
                first_part = parts[0].replace("alias ", "").strip()
                second_part = parts[1]
                returnable.append(DotFile.Alias(already_docs, first_part, second_part))
                returnable += parse_already_docs("", index + 1, lines)
            return returnable

        with open(file_location, "r", encoding="utf-8") as file:
            file_contents = file.read()

        file_contents_list = file_contents.split("\n")
        aliases = parse_already_docs("", 0, file_contents_list)

        dot_file = DotFile(file_location)
        dot_file.aliases = aliases
        return dot_file
