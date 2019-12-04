set -x GIT_EDITOR nvim
set -x EDITOR nvim
set -x PAGER less -R

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

abbr -a be bundle exec
abbr -a g git
abbr -a v nvim
abbr -a l ls -l
abbr -a ll ls -la

if test  (uname) = "Darwin"
  set PATH (path-reordered)
end

if test  (uname -a | grep "Microsoft")
  connect-to-weasel-pageant
  win-dircolors
end
