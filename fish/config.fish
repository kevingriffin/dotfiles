source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

set -U GIT_EDITOR nvim
set -U EDITOR nvim

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

set -x RUBY_GC_HEAP_INIT_SLOTS 600000
set -x RUBY_GC_HEAP_FREE_SLOTS 600000
set -x RUBY_GC_HEAP_GROWTH_FACTOR 1.25
set -x RUBY_GC_HEAP_GROWTH_MAX_SLOTS 300000
set -x RUBY_GC_MALLOC_LIMIT 64000000
set -x RUBY_GC_OLDMALLOC_LIMIT 64000000

set PATH /usr/local/bin $PATH {$HOME}/bin

abbr -a be bundle exec
abbr -a g git
abbr -a v nvim
abbr -a l ls -l
abbr -a ll ls -la

