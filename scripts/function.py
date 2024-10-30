def reload():
    # Reload the current terminal session
    import os
    os.system("source ~/.ally")

def unalias(args):
    # Parse the args
    # Call ally, then unalias the correct alias, and source ~/.ally
    import os
    os.system(f"ally {' '.join(args)}")
    for arg in args:
        if not arg.startswith("-"):
            if arg == args[0]:
                continue
            os.system(f"unalias {arg}")
            break
    reload()

def ally_function(args):
    # Call the ally cli tool with all args
    if args[0] == "remove":
        unalias(args)
    else:
        import os
        os.system(f"ally {' '.join(args)}")
