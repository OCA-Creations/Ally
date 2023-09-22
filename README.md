# Welcome to Ally (pronounced Al-eye)!
This project is functional, but is NOT YET READY FOR USE! You might damage your system or config by running it! For now, you should download the project, build, and then run the Executable it produces with `EXECUTABLE_LOC init`. You MUST HAVE zsh installed. This tool was hacked in a night - it is still being developed! It is actively in progress, and is currently used, but needs work!
Some ideas/todos:
- `ally dot` will open the .ally file
- `ally edit ALIAS "OLD_COMMAND"` will edit an alias
- The old command may not need to be in quotes.
- Allow equals signs: `ally add test=echo` is as valid as `ally add test 'echo'".
- `ally install --reinstall` will reinstall and format the dotfile
- `ally dot format` will format the dotfile
- Can we call things like `ally init` from a Swift file with pure Swift? Call the class directly?
- `ally zshrc` will transfer all current aliases to the .zshrc
- Improve the quality and organization of the project
- Improve command docs
- `ally list` will print a list of aliases
- `ally add ALIAS "OLD_COMMAND" -docs "DOCS""` will let the user add documentation for an alias (stored in a comment on the line above.)
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


