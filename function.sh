function _ally::reload() {
    # Reload the current terminal session
    source ~/.ally
}
# TODO: The function can take in arguments, so we need to fix the "unalias" part 
#       to unalias the correct alias, rather than some flag
function _ally::unalias() {
    # Parse the args
    # Call ally, then unalias $1 and source ~/.ally
    ally $@
    # Get the part that is not a flag
    for arg in $@; do
        if [[ $arg != -* ]]; then
            if [[ $arg == $1 ]]; then
                continue
            fi
            unalias $arg
            break
        fi
    done
    _ally::reload
}
function ally_function() {
    # Call the ally cli tool with all args
    if [ "$1" = "remove" ]; then
        _ally::unalias $@
    else
        ally $@
    fi
}