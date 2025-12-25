# Basics
set EDITOR zed
set VISUAL zed
set GIT_EDITOR "zed --wait"

# LC_CTYPE bug
set LC_CTYPE "en_US.UTF-8"
set LC_ALL "en_US"

# Only set some paths if those dirs exist
#
if [ -d "/opt/homebrew/bin" ]; set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths; end
if [ -d "/opt/homebrew/sbin" ]; set -g fish_user_paths "/opt/homebrew/sbin" $fish_user_paths; end

if [ -d "/usr/local/go/bin" ]; set -g fish_user_paths "/usr/local/go/bin" $fish_user_paths; end
if [ -d "$HOME/go/bin" ]; set -g fish_user_paths "$HOME/go/bin" $fish_user_paths; end

if [ -d "$HOME/.local/bin" ]; set -g fish_user_paths "$HOME/.local/bin" $fish_user_paths; end

if [ -d "$HOME/.cargo/bin" ]; set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths; end

if not contains "./bin" $PATH
  set -xg PATH ./bin $PATH
end

if not contains "node_modules/.bin" $PATH
  set -xg PATH node_modules/.bin $PATH
end

# These are hacks to support multiple laptops with slightly
# different home directory layouts
set -e Z_DATA
set -e Z_DATA_DIR
set -xg Z_DATA $HOME/.local/share/z/data
set -xg Z_DATA_DIR $HOME/.local/share/z

# Set git signing key based on home directory
# Lambda laptop has natik.gadzhi home, and this is the key it should use.
if string match -q "*natik.gadzhi*" $HOME
  set -xg GIT_CONFIG_USER_SIGNINGKEY 9D9EC67DDA83961A
end


# When GPG wants the key passphrase, but can't figure out which TTY to use to get it.
# set -e SSH_AGENT_PID
# set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
# set -xg GPG_TTY (tty)
# gpg-connect-agent updatestartuptty /bye >/dev/null
# set -xg PINENTRY_USER_DATA "USE_CURSES=1"

# Check if ssh-agent is already running, if not start it
# if not set -q SSH_AGENT_PID; or not ps -p $SSH_AGENT_PID > /dev/null 2>&1
#     eval (ssh-agent -c) > /dev/null 2>&1
# end

# pyenv setup was here, but this shit takes too long to load.
# use `uv` instead.

# gh completions - cached to file (saves ~24ms)
if command -q gh
  set -l gh_completion_cache "$HOME/.cache/fish/gh_completion.fish"
  if not test -f $gh_completion_cache
    mkdir -p (dirname $gh_completion_cache)
    gh completion -s fish > $gh_completion_cache
  end
  source $gh_completion_cache
end

# Direnv loads .env file into environment in trusted directories
# Only need the hook, not the separate export call
if command -q direnv
  direnv hook fish | source
end

# Git aliases
alias k="kubecolor"
alias gs="git status"
alias gc="git commit"
alias ga="git add"

function gp
    if git rev-parse --git-dir > /dev/null 2>&1
        git pull --ff origin (git rev-parse --abbrev-ref HEAD)
    else
        echo "Not in a git repository"
        return 1
    end
end

function gpu
    if git rev-parse --git-dir > /dev/null 2>&1
        git push origin (git rev-parse --abbrev-ref HEAD)
    else
        echo "Not in a git repository"
        return 1
    end
end

# If iTerm shell integration is there, source it
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Wasmer
set -gx WASMER_DIR "$HOME/.wasmer"
# This line checks if the file $WASMER_DIR/wasmer.sh exists and has a size greater than zero
# (using the -s test flag). If it exists, the script is sourced, which loads Wasmer's
# environment variables and functions into the current shell session
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
if [ -d ~/.orbstack ];
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :
end
