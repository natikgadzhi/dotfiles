# Pure prompt settings — user-owned, loads before the pure plugin.
#
# These lived in fish_variables as universal variables. That file is
# machine-local state which fish rewrites in place, and because
# ~/.config/fish is a symlinked directory, those writes landed in this
# repo — which is how Homebrew paths ended up on a Fedora box.
#
# Declared as globals here instead: version-controlled, identical on
# every machine, nothing writes back. conf.d loads alphabetically, so
# the 00- prefix puts this ahead of pure.fish, whose _pure_set_default
# only assigns when a value is unset — so these win.
#
# Do not edit conf.d/pure.fish: that is vendored plugin code (fisher).

set -g pure_begin_prompt_with_current_directory true
set -g pure_check_for_new_release false
set -g pure_color_at_sign pure_color_mute
set -g pure_color_aws_profile pure_color_warning
set -g pure_color_command_duration pure_color_warning
set -g pure_color_current_directory pure_color_primary
set -g pure_color_danger red
set -g pure_color_dark black
set -g pure_color_git_branch pure_color_mute
set -g pure_color_git_dirty pure_color_mute
set -g pure_color_git_stash pure_color_info
set -g pure_color_git_unpulled_commits pure_color_info
set -g pure_color_git_unpushed_commits pure_color_info
set -g pure_color_hostname pure_color_mute
set -g pure_color_info cyan
set -g pure_color_jobs pure_color_normal
set -g pure_color_k8s_context pure_color_success
set -g pure_color_k8s_namespace pure_color_primary
set -g pure_color_k8s_prefix pure_color_info
set -g pure_color_light white
set -g pure_color_mute brblack
set -g pure_color_nixdevshell_prefix pure_color_info
set -g pure_color_nixdevshell_symbol pure_color_mute
set -g pure_color_normal normal
set -g pure_color_prefix_root_prompt pure_color_danger
set -g pure_color_primary blue
set -g pure_color_prompt_on_error pure_color_danger
set -g pure_color_prompt_on_success pure_color_success
set -g pure_color_success magenta
set -g pure_color_system_time pure_color_mute
set -g pure_color_username_normal pure_color_mute
set -g pure_color_username_root pure_color_light
set -g pure_color_virtualenv pure_color_mute
set -g pure_color_warning yellow
set -g pure_enable_aws_profile true
set -g pure_enable_container_detection true
set -g pure_enable_git true
set -g pure_enable_k8s false
set -g pure_enable_nixdevshell false
set -g pure_enable_single_line_prompt false
set -g pure_enable_virtualenv true
set -g pure_reverse_prompt_symbol_in_vimode true
set -g pure_separate_prompt_on_error false
set -g pure_shorten_prompt_current_directory_length 16
set -g pure_shorten_window_title_current_directory_length 0
set -g pure_show_jobs false
set -g pure_show_prefix_root_prompt false
set -g pure_show_subsecond_command_duration false
set -g pure_show_system_time false
set -g pure_symbol_aws_profile_prefix ''
set -g pure_symbol_container_prefix ''
set -g pure_symbol_git_dirty '*'
set -g pure_symbol_git_stash ≡
set -g pure_symbol_git_unpulled_commits ⇣
set -g pure_symbol_git_unpushed_commits ⇡
set -g pure_symbol_k8s_prefix ☸
set -g pure_symbol_nixdevshell_prefix ❄️
set -g pure_symbol_prefix_root_prompt '#'
set -g pure_symbol_prompt ❯
set -g pure_symbol_reverse_prompt ❮
set -g pure_symbol_ssh_prefix ''
set -g pure_symbol_title_bar_separator -
set -g pure_symbol_virtualenv_prefix ''
set -g pure_threshold_command_duration 5
set -g pure_truncate_prompt_current_directory_keeps 2
set -g pure_truncate_window_title_current_directory_keeps -1

# Show the machine name on every prompt, not just over SSH.
#
# Pure fills that slot with _pure_prompt_ssh, which prints user@host only
# when $SSH_CONNECTION is set — useless in tmux, mosh, and console sessions
# where the variable never reaches the shell. Defining the function here
# shadows the vendored functions/_pure_prompt_ssh.fish, because fish only
# autoloads a function that is not already defined.
function _pure_prompt_ssh
    echo (_pure_set_color $pure_color_hostname)$hostname
end
