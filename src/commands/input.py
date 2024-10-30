import sys

def input(prompt=None, terminator="\n"):
    if prompt:
        print(prompt, end=terminator)
    return sys.stdin.readline().strip()

def input_with_items(*items, separator=" ", terminator="\n"):
    print(separator.join(map(str, items)), end=terminator)
    return sys.stdin.readline().strip()
