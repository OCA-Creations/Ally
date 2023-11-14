<img src="https://user-images.githubusercontent.com/104732280/282874044-6ccf9357-c35f-49ed-bc0f-76a841f1a9b6.svg" alt="Ally Logo" width=24em></img>
# Welcome to Ally!
This project is functional, but is NOT YET READY FOR USE! You might damage your system or config by running it! To install:
## Installation
One-liner:
```
curl https://raw.githubusercontent.com/OCA-Creations/Ally/main/install.sh | sh
```
> [!NOTE]
> The one-liner above assumes this install is **not** intended to be used for development of the Ally tool itself. Also, if you already have a directory named `Ally` in the location in which you are running the script, then install will fail with the following error:
> ```
> fatal: destination path 'Ally' already exists and is not an empty directory.
> ```
If you wish to install for development, follow the steps below:
1. Download + Build the project (`git clone` and `swift build` in the folder)
2. Locate the built executable and move it to the desired location.
3. Run the executable with the parameter `init`.
4. Keep developing and building `ally` in the original directory - you may want to use it to add an alias to the Derived Data build!
## This tool was hacked in a night - it is still being developed! It is actively in progress, and is currently used, but needs work!
Some ideas/todos (strikethrough indicates complete):
- <s>`ally dot` will open the .ally file</s>
- `ally edit ALIAS "OLD_COMMAND"` will edit an alias
    - The old command may not need to be in quotes.
- <s>Allow equals signs: `ally add test=echo` is as valid as `ally add test 'echo'`.</s>
- `ally install --reinstall` will reinstall and format the dotfile
- `ally dot format` will format the dotfile
- Can we call things like `ally init` from a Swift file with pure Swift? Call the class directly?
- `ally zshrc` will transfer all current aliases to the .zshrc
- Improve the quality and organization of the project
- Improve command docs
- <s>`ally list` will print a list of aliases</s>
- `ally add ALIAS "OLD_COMMAND" -docs "DOCS"` will let the user add documentation for an alias (stored in a comment on the line above.)
- Support bash and fish shells.
- Currently, reload doesn't do anything. Can we fix this or remove it altogether?
- Currently, quotes need to be escaped. Can we auto-escape them?
- When installing, if `--reinstall` is not specified, don't overwrite the .ally file!
- Should we rename to something other than .ally?
- Should we have a custom file format like https://github.com/DannyBen/alf\?
- Check out https://github.com/DannyBen/bashly
- Should this be public? How can we improve it first?
- Add an sh install script for oneliner install.
- Add tests (and allow custom directories to be inputted for them)?
- Allow the user to add a custom name for ally? `ally name CUSTOM_NAME`?
- Improve code and args for all commands.
- Add docs.
- Add a man page? ([#2](https://github.com/OCA-Creations/Ally/issues/2)
- Convert all of these notes into issues on GitHub.
- Should we have automatic alias generation based on frequently used commands?
- Should we have a list of aliases that you can add? `ally defaults DEFAULT_LIST_NAME`?
- `ally debug -o OUTPUT_FILE_LOCATION` should save a debug report (text file) for contributors to track bugs and other things.
- Some ideas for defaults:
    - `os-interop` will let you transport Windows or UNIX commands to your current OS. If you're on Windows, then this would enable `ls` (`dir`), `touch`, etc. This would conversely enable `dir` as a replacement for `ls` on UNIX.
    - `hacking` - all the aliases and tools one needs to hack.
    - `allyutils` or `generalutils` - these are things that make using `ally` or the Terminal easier, such as a `reload` command that reloads everything - `source $HOME_DIR/.ally`, etc.
- Improve verbosity, especially when adding a command. This could be specified with a degree of verbosity (like TensorFlow). We would need to warn users when entering aliases that already exist or aliasing over existing commands (see CommandRunner.swift to test out if a command already exists).
- What if we allowed users to create their own CLI tools from scripts? So the user passes in `ally add SCRIPT.py` (or another language), and then ally adds an alias for the script, and creates a CLI for it?
- Add to PATH instead of an alias.
- Save and restore backups of `.ally` files
    - Allow sharing + install of custom `.ally` files
