# Basics
set EDITOR nvim
set VISUAL nvim
set GIT_EDITOR nvim

# When GPG wants the key passphrase, but can't figure out which TTY to use to get it.
set -xg GPG_TTY (tty)
set -e SSH_AGENT_PID
set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# LC_CTYPE bug
set LC_CTYPE "en_US.UTF-8"
set LC_ALL "en_US"

# Only set some paths if those dirs exist
#
if [ -d "/opt/homebrew/bin" ]; set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths; end
if [ -d "/opt/homebrew/sbin" ]; set -g fish_user_paths "/opt/homebrew/sbin" $fish_user_paths; end

if [ -d "/usr/local/go/bin" ]; set -g fish_user_paths "/usr/local/go/bin" $fish_user_paths; end
if [ -d (echo ~)"/go/bin" ]; set -g fish_user_paths (echo ~)"/go/bin" $fish_user_paths; end

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

alias k="kubectl"
# Git aliases
alias gs="git status"
# alias gco="git checkout"
# alias gb="git branch"
# alias gp="git push"
# alias gl="git pull"
alias b="bundle exec"

set fish_git_dirty_color red
set fish_git_not_dirty_color white

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)

  if test -n "$git_diff"
    echo (set_color $fish_git_dirty_color --bold)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color --bold)$branch(set_color normal)
  end
end

function git_fish_prompt
  if test -d .git
    printf '%s%s:%s %s%s ' (set_color $fish_color_cwd) (prompt_hostname) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s%s:%s%s ' (set_color $fish_color_cwd) (prompt_hostname) (prompt_pwd) (set_color normal)
  end
end

if not type -q __orig_fish_prompt; functions -c fish_prompt __orig_fish_prompt; end

functions -e fish_prompt
functions -c git_fish_prompt fish_prompt

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/xnutsive/code/google-cloud-sdk/path.fish.inc' ]; . '/Users/xnutsive/code/google-cloud-sdk/path.fish.inc'; end

ulimit -n 2048

