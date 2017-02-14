# Aliases ##

# Network
alias ipaddress="ifconfig | grep "broadcast" | cut -d \" \" -f2 | head -n1"
alias globalip="dig +short myip.opendns.com @resolver1.opendns.com"
alias chomp="tr -d \"\n\""

# Bash
export HISTSIZE=5000

# Others
alias ll="ls -la"
alias l="ls -l"
alias pbclean="pbpaste | pbcopy"
alias fuzz="source ~/.bash_profile"
alias be="bundle exec"
alias dsclean="noglob find . -name *.DS_Store -type f -delete"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# iKnow
alias ik="cd /code/iknow"
alias ec="cd /code/eikaiwa_content"
alias ecf="cd /code/eikaiwa_content_frontend"
alias eclog="tail -f /code/eikaiwa_content/log/development.log"
alias eclogt="tail -f /code/eikaiwa_content/log/test.log"
alias deploy="cd /code/smart_deploy"
alias chefctl="cd /code/chef-ctl"
alias iknow_deploy_env="chef-ctl e iknowjp_production"

alias stable="g checkout -q origin/stable"

## Ruby ##
export RUBY_GC_HEAP_INIT_SLOTS=600000
export RUBY_GC_HEAP_FREE_SLOTS=600000
export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000

export RUBY_GC_MALLOC_LIMIT=64000000
export RUBY_GC_OLDMALLOC_LIMIT=64000000

alias rc="pry -r ./config/environment"

# Git
function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function parse_git_branch_clean() {
	parse_git_branch | tr -d '()'
}

alias g=git
alias gfe='g fetch'
alias gpu='g push origin `parse_git_branch_clean`'
alias gpl='g pull origin `parse_git_branch_clean`'
alias gs='g status'
alias gc='g checkout'
alias gm='g commit -m'
alias gd='g diff'
alias gb='g branch'
GIT_EDITOR="nvim"
EDITOR="nvim"

#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE="en_US.UTF-8"
export TERM=xterm-256color
# Path
export PATH="/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/Users/Kevin/Library/Scripts/Shell:/usr/local/mysql/bin:/Users/kevin/.bin:/Users/Kevin/Development/Cerego/bin:/usr/local/share/npm/bin:$PATH"

## Prompt ##
PS1="\W | \@ \$(parse_git_branch)始 "
