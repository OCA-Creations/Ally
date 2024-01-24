# The core function that makes Ally work
function ally {
    # We will be reloading by default
    IFS=$'\n'
    ARGS=$@
    _ally $ARGS
    source ~/.ally
}
