# Basics
set EDITOR vim
set VISUAL vim
set GIT_EDITOR vim

# When GPG wants the key passphrase, but can't figure out which TTY to use to get it.
set -xg GPG_TTY (tty)

gpgconf --launch gpg-agent
set SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh

# LC_CTYPE bug
set LC_CTYPE "en_US.UTF-8"
set LC_ALL "en_US"

# Only set some paths if those dirs exist
#
if [ -d "/usr/local/sbin" ]; set -g fish_user_paths "/usr/local/sbin" $fish_user_paths; end
if [ -d "/usr/local/opt/python@3.8/bin" ]; set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths; end

if [ -d "~/.local/bin" ]; set -g fish_user_paths "~/.local/bin" $fish_user_paths; end

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

alias k="kubectl"
# Git aliases
alias gs="git status"
# alias gco="git checkout"
# alias gb="git branch"
# alias gp="git push"
# alias gl="git pull"

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
