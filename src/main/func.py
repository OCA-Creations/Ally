def ally(*args):
    import subprocess
    import os

    # We will be reloading by default
    args = list(args)
    subprocess.run(["_ally"] + args)
    subprocess.run(["source", os.path.expanduser("~/.ally")], shell=True)
