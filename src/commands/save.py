import argparse
import os

class SaveOptions:
    def __init__(self):
        pass

class DotSave:
    @staticmethod
    def configure_parser(subparsers):
        parser = subparsers.add_parser('save', help='Save the .ally file to a given location for sharing or later use.')
        parser.set_defaults(func=DotSave.run)

    @staticmethod
    def run(args):
        pass

def main():
    parser = argparse.ArgumentParser(description='Ally - ZSH Alias Manager')
    subparsers = parser.add_subparsers()

    DotSave.configure_parser(subparsers)

    args = parser.parse_args()
    if hasattr(args, 'func'):
        args.func(args)
    else:
        parser.print_help()

if __name__ == '__main__':
    main()
