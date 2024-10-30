import argparse
from helpers.dot_file import DotFile

class ListOptions:
    def __init__(self):
        parser = argparse.ArgumentParser(description="List all commands added with ally.")
        parser.add_argument('--no-docs', action='store_true', help="Don't output the included, user-created docs for the command.")
        parser.add_argument('--output-location', type=str, help="The output file location. All list output will be saved to this file.")
        self.args = parser.parse_args()

class AllyList:
    def __init__(self):
        self.options = ListOptions()

    def run(self):
        try:
            dot_file = DotFile.parse_ally_file(DotFile.dot_file_location)
            dot_file.output(docs=not self.options.args.no_docs)
        except Exception as e:
            print(f"There was an error reading your .ally file: {str(e)}.")

if __name__ == "__main__":
    ally_list = AllyList()
    ally_list.run()
