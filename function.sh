function ally {
    # Check for --no-reload flag
    if [[ " $* " =~ "--no-reload" ]]; then
        # Call the _ally cli tool with all args except --no-reload
        _ally "${@/--no-reload/}"
    else
        # Call the _ally cli tool with all args and reload
        _ally $@
        source ~/.ally
    fi
}
