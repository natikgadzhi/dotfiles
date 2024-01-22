# Basics
set EDITOR nvim
set VISUAL nvim
set GIT_EDITOR nvim

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

# When GPG wants the key passphrase, but can't figure out which TTY to use to get it.
set -e SSH_AGENT_PID
set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -xg GPG_TTY (tty)
#gpg-connect-agent updatestartuptty /bye >/dev/null

#set -xg PINENTRY_USER_DATA "USE_CURSES=1"

# rbenv
if [ -d (echo ~)"/.rbenv" ]
  source (rbenv init -|psub)
end

if not contains ".rbenv/shims" $PATH
  set -xg PATH "~/.rbenv/shims" $PATH
end

if [ -x (which pyenv) ]
  set -Ux PYENV_ROOT $HOME/.pyenv
  set -g fish_user_paths $PYENV_ROOT/shims $fish_user_paths
  pyenv init - |source
end

if not contains "./bin" $PATH
  set -xg PATH ./bin $PATH
end

if not contains "node_modules/.bin" $PATH
  set -xg PATH node_modules/.bin $PATH
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
# alias gco="git checkout"
# alias gb="git branch"
# alias gp="git push"
# alias gl="git pull"

# If iTerm shell integration is there, source it
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

ulimit -n 2048

# pyenv init
status is-login; and pyenv init --path | source
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

if [ -d /opt/homebrew/opt/openjdk/ ];
  set -gx JAVA_HOME /opt/homebrew/opt/openjdk
  set -gx PATH $JAVA_HOME/bin $PATH
end
