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
if [ -d (echo ~)"/go/bin" ]; set -g fish_user_paths (echo ~)"/go/bin" $fish_user_paths; end

if [ -d (echo ~)"/.local/bin" ]; set -g fish_user_paths (echo ~)"/.local/bin" $fish_user_paths; end

if [ -d (echo ~)"/.cargo/bin" ]; set -g fish_user_paths (echo ~)"/.cargo/bin" $fish_user_paths; end

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
set -xg Z_DATA (echo ~)/.local/share/z/data
set -xg Z_DATA_DIR (echo ~)/.local/share/z

# Set git signing key based on home directory
# Lambda laptop has natik.gadzhi home, and this is the key it should use.
if string match -q "*natik.gadzhi*" (echo ~)
  set -xg GIT_CONFIG_USER_SIGNINGKEY 9D9EC67DDA83961A
end


# When GPG wants the key passphrase, but can't figure out which TTY to use to get it.
# set -e SSH_AGENT_PID
# set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -xg GPG_TTY (tty)
# gpg-connect-agent updatestartuptty /bye >/dev/null
# set -xg PINENTRY_USER_DATA "USE_CURSES=1"

eval (ssh-agent -c)

# rbenv
if [ -d (echo ~)"/.rbenv" ]
  source (rbenv init -|psub)
end

if not contains ".rbenv/shims" $PATH
  set -xg PATH "~/.rbenv/shims" $PATH
end

if [ -d (echo ~)"/.jenv" ]
  status --is-interactive; and jenv init - | source
end

# Use fzf in Fish ctrl-r
if [ -x (which fzf) ]; fzf --fish | source; end

if [ -x (which pyenv) ]
  set -gx PYENV_ROOT $HOME/.pyenv
  set -g fish_user_paths $PYENV_ROOT/shims $fish_user_paths
  pyenv init - |source
end

# Add gh completions
if [ -x (which gh) ]
  eval (gh completion -s fish)
end

# Direnv loads .env file into environment in trusted directories
# Ruby's dotenv does similar.
if [ -x (which direnv) ]
  direnv hook fish | source
  direnv export fish |source
end

if [ -x (which shadowenv) ]
  shadowenv init fish | source
end

# Git aliases
alias gs="git status"
alias k="kubectl"

# If iTerm shell integration is there, source it
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

ulimit -n 2048

# pyenv init
status is-login; and pyenv init --path | source

# Wasmer
set -gx WASMER_DIR "/Users/natikgadzhi/.wasmer"
# This line checks if the file $WASMER_DIR/wasmer.sh exists and has a size greater than zero
# (using the -s test flag). If it exists, the script is sourced, which loads Wasmer's
# environment variables and functions into the current shell session
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# TODO: Unsure why, this started failing around January 2025s
# source (brew --prefix asdf)/libexec/asdf.fish

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
