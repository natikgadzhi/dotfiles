# Basics
set EDITOR vim
set VISUAL vim
set GIT_EDITOR vim

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

set --universal fish_color_autosuggestion 4D5566 # ayu:common.ui        autosuggestions
set --universal fish_color_command        39BAE6 # ayu:syntax.tag       commands
set --universal fish_color_comment        626A73 # ayu:syntax.comment   code comments
set --universal fish_color_cwd            59C2FF # ayu:syntax.entity    current working directory in the default prompt
set --universal fish_color_end            F29668 # ayu:syntax.operator  process separators like ';' and '&'
set --universal fish_color_error          FF3333 # ayu:syntax.error     highlight potential errors
set --universal fish_color_escape         95E6CB # ayu:syntax.regexp    highlight character escapes like '\n' and '\x70'
set --universal fish_color_match          F07178 # ayu:syntax.markup    highlight matching parenthesis
set --universal fish_color_normal         B3B1AD # ayu:common.fg        default color
set --universal fish_color_operator       E6B450 # ayu:syntax.accent    parameter expansion operators like '*' and '~'
set --universal fish_color_param          B3B1AD # ayu:common.fg        regular command parameters
set --universal fish_color_quote          C2D94C # ayu:syntax.string    quoted blocks of text
set --universal fish_color_redirection    FFEE99 # ayu:syntax.constant  IO redirections
set --universal fish_color_search_match   --background E6B450 # ayu:syntax.accent    highlight history search matches and the selected pager item (must be a background)
set --universal fish_color_selection      E6B450 # ayu:syntax.accent    when selecting text (in vi visual mode)

# color for fish default prompts item
set --universal fish_color_cancel         0A0E14 # ayu:common.bg        the '^C' indicator on a canceled command
set --universal fish_color_host           FFEE99 # ayu:syntax.constant  current host system in some of fish default prompts
set --universal fish_color_host_remote    FFEE99 # ayu:syntax.constant  current host system in some of fish default prompts, if fish is running remotely (via ssh or similar)
set --universal fish_color_user           FF8F40 # ayu:syntax.keyword   current username in some of fish default prompts

# # TokyoNight Color Palette
# set -l foreground c0caf5
# set -l selection 33467C
# set -l comment 565f89
# set -l red f7768e
# set -l orange ff9e64
# set -l yellow e0af68
# set -l green 9ece6a
# set -l purple 9d7cd8
# set -l cyan 7dcfff
# set -l pink bb9af7

# # Syntax Highlighting Colors
# set -g fish_color_normal $foreground
# set -g fish_color_command $cyan
# set -g fish_color_keyword $pink
# set -g fish_color_quote $yellow
# set -g fish_color_redirection $foreground
# set -g fish_color_end $orange
# set -g fish_color_error $red
# set -g fish_color_param $purple
# set -g fish_color_comment $comment
# set -g fish_color_selection --background=$selection
# set -g fish_color_search_match --background=$selection
# set -g fish_color_operator $green
# set -g fish_color_escape $pink
# set -g fish_color_autosuggestion $comment

# # Completion Pager Colors
# set -g fish_pager_color_progress $comment
# set -g fish_pager_color_prefix $cyan
# set -g fish_pager_color_completion $foreground
# set -g fish_pager_color_description $comment


