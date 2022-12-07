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

# When GPG wants the key passphrase, but can't figure out which TTY to use to get it.
set -xg GPG_TTY (tty)
set -e SSH_AGENT_PID
set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# rbenv
if test -d ~/.rbenv
  source (rbenv init -|psub)
end

if not contains ".rbenv/shims" $PATH
  set -xg PATH "~/.rbenv/shims" $PATH
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

if [ -x (which direnv) ]
  direnv hook fish | source
  direnv export fish |source
end

# Git aliases
alias gs="git status"
# alias gco="git checkout"
# alias gb="git branch"
# alias gp="git push"
# alias gl="git pull"
alias b="bundle exec"

# If iTerm shell integration is there, source it
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# if starship prompt is installed, source it's config.
# brew install starship
if [ -x (which starship) ]
  starship init fish | source
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/xnutsive/code/google-cloud-sdk/path.fish.inc' ]; . '/Users/xnutsive/code/google-cloud-sdk/path.fish.inc'; end

ulimit -n 2048

