![AllyLogo](https://github.com/OCA-Creations/Ally/assets/104732280/6ccf9357-c35f-49ed-bc0f-76a841f1a9b6)<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<!-- Created with Vectornator (http://vectornator.io/) -->
<svg height="100%" stroke-miterlimit="10" style="fill-rule:nonzero;clip-rule:evenodd;stroke-linecap:round;stroke-linejoin:round;" version="1.1" viewBox="0 0 2000 1140" width="100%" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:vectornator="http://vectornator.io" xmlns:xlink="http://www.w3.org/1999/xlink">
<defs/>
<clipPath id="ArtboardFrame">
<rect height="1140" width="2000" x="0" y="0"/>
</clipPath>
<g clip-path="url(#ArtboardFrame)" id="Layer-1" vectornator:layerName="Layer-1">
<g opacity="1" vectornator:layerName="g">
<g opacity="1" vectornator:layerName="g">
<path d="M195.599 757.26L299.569 598.76L195.599 440.05L265.619 440.05L367.679 598.76L265.619 757.26L195.599 757.26Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
<path d="M894.519 721.4L933.989 721.4L835.329 415.223L795.439 415.223L696.769 721.4L734.749 721.4L761.489 633.56L867.999 633.56L894.519 721.4ZM814.319 460.2L815.379 460.2L858.239 601.52L771.249 601.52L814.319 460.2Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
<path d="M1184.57 721.4L1184.57 691.48L1108.61 691.48L1108.61 400.795L994.459 400.795L994.459 430.71L1072.54 430.71L1072.54 691.48L993.819 691.48L993.819 721.4L1184.57 721.4Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
<path d="M1453.19 721.4L1453.19 691.48L1377.23 691.48L1377.23 400.795L1263.08 400.795L1263.08 430.71L1341.16 430.71L1341.16 691.48L1262.44 691.48L1262.44 721.4L1453.19 721.4Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
<path d="M1556.74 803.3C1599.39 803.3 1618.7 786.54 1638.85 729.89L1725.63 491.18L1687.23 491.18L1622.94 683.84L1620.18 683.84L1555.68 491.18L1516.42 491.18L1601.08 722.88L1597.05 735.4C1587.5 762.14 1575.62 771.9 1553.98 771.9C1550.59 771.9 1544.01 771.69 1541.25 771.05L1541.25 802.66C1544.43 803.09 1551.43 803.3 1556.74 803.3Z" fill="#605cde" fill-rule="nonzero" opacity="1" stroke="none" vectornator:layerName="path"/>
</g>
<g opacity="1" vectornator:layerName="use">
<clipPath clip-rule="nonzero" id="ClipPath">
<path d="M0 24.9062L0 1115.09L2003.97 1115.09L2003.97 24.9062L0 24.9062ZM155.75 42.2188L1848.19 42.2188C1924.65 42.2188 1986.66 104.192 1986.66 180.656L1986.66 959.344C1986.66 1035.8 1924.65 1097.78 1848.19 1097.78L155.75 1097.78C79.29 1097.78 17.2813 1035.8 17.2812 959.344L17.2812 180.656C17.2812 104.192 79.29 42.2187 155.75 42.2188Z"/>
</clipPath>
<g clip-path="url(#ClipPath)">
<path d="M17.2887 180.664C17.2887 104.2 79.2787 42.213 155.739 42.213L1848.2 42.213C1924.66 42.213 1986.65 104.2 1986.65 180.664L1986.65 959.34C1986.65 1035.8 1924.66 1097.79 1848.2 1097.79L155.739 1097.79C79.2787 1097.79 17.2887 1035.8 17.2887 959.34L17.2887 180.664Z" fill="none" opacity="1" stroke="#c2d047" stroke-linecap="butt" stroke-linejoin="round" stroke-width="34.6128" vectornator:layerName="path"/>
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
    - Allow sharing + install of custom `.ally` files?
- Allow another syntax in `add` command: `->`
    - This would allow us to add things like:
    ```
    ally add getPID -> "ps aux | grep"
    ```
    - Mimics Swift function naming
