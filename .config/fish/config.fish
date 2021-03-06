set -x GIT_EDITOR nvim
set -x EDITOR nvim
set -x PAGER less -R

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -g theme_display_vagrant no
set -g theme_display_docker_machine no
set -g theme_display_k8s_context yes
set -g theme_display_hg no
set -g theme_display_virtualenv no
set -g theme_display_nix yes
set -g theme_display_ruby no
set -g theme_display_nvm no
set -g theme_display_user no
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_date_timezone Asia/Tokyo
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_jobs_verbose yes
set -g theme_color_scheme gruvbox
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -g theme_newline_prompt ''
set -g theme_display_sudo_user yes

abbr -a be bundle exec
abbr -a g git
abbr -a v nvim
abbr -a l ls -l
abbr -a ll ls -la
abbr -a ddl cd $HOME/Downloads
abbr -a icl cd "$HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
abbr -a tmp cd "$HOME/tmp"
abbr -a src cd "$HOME/src"
abbr -a dot cd "$HOME/dotfiles"
abbr -a ik cd "$HOME/src/iknow"
abbr -a ec cd "$HOME/src/eikaiwa_content"
abbr -a ecf cd "$HOME/src/eikaiwa_content_frontend"
abbr -a ecr cd "$HOME/src/eikaiwa-realtime"

if test  (uname) = "Darwin"
  set PATH (path-reordered)
end
