# Basics
set EDITOR vim
set VISUAL vim
set GIT_EDITOR vim

set -xg GPG_TTY (tty)

# LC_CTYPE bug
set LC_CTYPE "en_US.UTF-8"
set LC_ALL "en_US"
# alias git="env LC_MESSAGES=en_US git"

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

functions -c fish_prompt __orig_fish_prompt
functions -e fish_prompt
functions -c git_fish_prompt fish_prompt

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/xnutsive/code/google-cloud-sdk/path.fish.inc' ]; . '/Users/xnutsive/code/google-cloud-sdk/path.fish.inc'; end

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths
