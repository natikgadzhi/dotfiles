#!/bin/bash

# Determine if we're in a terminal or a GUI application
if [[ -n "$SSH_TTY" ]]; then
    # Running in a remote terminal
    /opt/homebrew/bin/pinentry "$@"
elif [[ -n "$TMUX" || -n "$STY" ]]; then
    # Running in a terminal multiplexer
    /opt/homebrew/bin/pinentry "$@"
elif [[ -n "$GPG_TTY" ]]; then
    # GPG_TTY is set, indicating terminal use
    /opt/homebrew/bin/pinentry "$@"
else
    # Assume GUI environment otherwise
    /opt/homebrew/bin/pinentry-mac "$@"
fi
