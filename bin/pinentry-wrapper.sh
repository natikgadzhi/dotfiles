#!/bin/bash

# Function to get the current TTY
get_current_tty() {
    if [ -t 0 ]; then
        # If stdin is a terminal, use it
        tty
    elif [ -n "$GPG_TTY" ]; then
        # If GPG_TTY is set, use it
        echo "$GPG_TTY"
    else
        # Fallback to the default tty command
        tty
    fi
}

# Determine if we're in a terminal or a GUI application
if [[ -n "$SSH_TTY" ]] || [[ -n "$TMUX" ]] || [[ -n "$STY" ]] || [[ -t 0 ]]; then
    # Running in a terminal environment (SSH, tmux, screen, or interactive shell)
    export GPG_TTY=$(get_current_tty)
    /opt/homebrew/bin/pinentry-curses "$@"
else
    # Assume GUI environment otherwise
    /opt/homebrew/bin/pinentry-mac "$@"
fi
