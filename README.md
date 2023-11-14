
![AllyLogoSmall](https://github.com/OCA-Creations/Ally/assets/104732280/5681e523-1abb-4a59-8b74-3285a0f6d61a)<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<!-- Created with Vectornator (http://vectornator.io/) -->
<svg height="100%" stroke-miterlimit="10" style="fill-rule:nonzero;clip-rule:evenodd;stroke-linecap:round;stroke-linejoin:round;" version="1.1" viewBox="0 0 500 274.683" width="100%" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:vectornator="http://vectornator.io" xmlns:xlink="http://www.w3.org/1999/xlink">
<defs/>
<clipPath id="ArtboardFrame">
<rect height="274.683" width="500" x="0" y="0"/>
</clipPath>
<g clip-path="url(#ArtboardFrame)" id="Layer-1" vectornator:layerName="Layer-1">
<g opacity="1" vectornator:layerName="g">
<g opacity="1" vectornator:layerName="g">
<path d="M46.8502 184.499L73.043 144.569L46.8502 104.586L64.4901 104.586L90.2017 144.569L64.4901 184.499L46.8502 184.499Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
<path d="M222.927 175.465L232.87 175.465L208.015 98.3311L197.966 98.3311L173.108 175.465L182.676 175.465L189.413 153.336L216.245 153.336L222.927 175.465ZM202.722 109.662L202.989 109.662L213.787 145.264L191.872 145.264L202.722 109.662Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
<path d="M295.998 175.465L295.998 167.928L276.861 167.928L276.861 94.6963L248.104 94.6963L248.104 102.233L267.775 102.233L267.775 167.928L247.943 167.928L247.943 175.465L295.998 175.465Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
<path d="M363.67 175.465L363.67 167.928L344.534 167.928L344.534 94.6963L315.777 94.6963L315.777 102.233L335.447 102.233L335.447 167.928L315.615 167.928L315.615 175.465L363.67 175.465Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
<path d="M389.757 196.098C400.502 196.098 405.367 191.876 410.443 177.604L432.305 117.467L422.631 117.467L406.435 166.003L405.739 166.003L389.49 117.467L379.6 117.467L400.928 175.838L399.912 178.992C397.507 185.729 394.514 188.187 389.062 188.187C388.208 188.187 386.55 188.135 385.855 187.973L385.855 195.937C386.656 196.045 388.42 196.098 389.757 196.098Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
</g>
<g opacity="1" vectornator:layerName="use">
<clipPath clip-rule="nonzero" id="ClipPath">
<path d="M-2.42631 0L-2.42631 274.647L502.426 274.647L502.426 0L-2.42631 0ZM36.8112 4.36148L463.181 4.36148C482.443 4.36148 498.065 19.9742 498.065 39.2375L498.065 235.409C498.065 254.672 482.443 270.285 463.181 270.286L36.8112 270.286C17.5489 270.286 1.92731 254.672 1.92729 235.409L1.92729 39.2375C1.92729 19.9742 17.5489 4.36147 36.8112 4.36148Z"/>
</clipPath>
<g clip-path="url(#ClipPath)">
<path d="M1.92918 39.2395C1.92918 19.9762 17.5461 4.36003 36.8084 4.36003L463.184 4.36003C482.446 4.36003 498.063 19.9762 498.063 39.2395L498.063 235.409C498.063 254.671 482.446 270.288 463.184 270.288L36.8084 270.288C17.5461 270.288 1.92918 254.671 1.92918 235.409L1.92918 39.2395Z" fill="none" opacity="1" stroke="#c2d047" stroke-linecap="butt" stroke-linejoin="round" stroke-width="8.71988" vectornator:layerName="path"/>
</g>
</g>
</g>
</g>
</svg>


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
