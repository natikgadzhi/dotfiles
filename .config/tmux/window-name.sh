#!/bin/sh
# Maps pane_current_command to a friendly display name for tmux windows.
# Usage: window-name.sh <pane_current_command>
cmd="$1"
case "$cmd" in
  fish|bash|zsh) echo "" ;;
  *claude*|*Claude*) echo ": Claude" ;;
  *codex*|*Codex*) echo ": Codex" ;;
  nvim|vim|vi) echo ": $cmd" ;;
  *)
    # Claude Code's binary is named by version and lives here
    if [ -f "$HOME/.local/share/claude/versions/$cmd" ]; then
      echo ": Claude"
    else
      echo ": $cmd"
    fi
    ;;
esac
