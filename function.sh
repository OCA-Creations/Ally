function _ally::reload() {
    # Reload the current terminal session
    source ~/.ally
}

function ally_function() {
    # Check for --no-reload flag
    if [[ " $* " == *" --no-reload "* ]]; then
        # Call the _ally cli tool with all args except --no-reload
        _ally "${@/--no-reload/}"
    else
        # Call the _ally cli tool with all args and reload
        _ally $@
        _ally::reload
    fi
}
