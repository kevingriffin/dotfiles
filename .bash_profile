# Aliases ##

# Network
alias ipaddress="ifconfig | grep "broadcast" | cut -d \" \" -f2 | head -n1"
alias globalip="dig +short myip.opendns.com @resolver1.opendns.com"
alias chomp="tr -d \"\n\""

# Bash
export HISTSIZE=5000

function bundle() {
if [ -d 'bin' ]
then
  ./bin/bundle "$@"
else `which bundle` "$@"
fi
}

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

# Others
alias ll="ls -la"
alias l="ls -l"
alias hislookup="history | grep -i"
alias pbclean="pbpaste | pbcopy"
alias fuzz="source ~/.bash_profile"
alias zipfolder="zip -r"
alias postgres_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias be="bundle exec"
alias dsclean="noglob find . -name *.DS_Store -type f -delete"
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias gems="vim \`rvm gempath | cut -d : -f1\`/gems"

export ARCHFLAGS="-arch i386 -arch x86_64"

function bundle() {
    if git rev-parse --is-inside-git-dir 2>/dev/null >&2; then
        BUNDLER="$(git rev-parse --show-toplevel)/bin/bundle"
        if [ -f ${BUNDLER} -a -x ${BUNDLER} ]; then
            ${BUNDLER} "$@"
        else
            "$(which bundle)" "$@"
        fi
    else
        "$(which bundle)" "$@"
    fi
}

# iKnow
alias smc="cd /data/smart_core"
alias iknow="cd /data/iknow"
alias api="cd /data/smart_api"
alias deploy="cd /data/smart_deploy"
alias chefctl="cd /data/chef-ctl"
alias iknow_deploy_env="chef-ctl e iknowjp_production"

alias stable="g checkout -q origin/stable"
alias remigrate="RAILS_ENV=test be rake cerego:db:remigrate"

## Ruby ##
export RUBY_GC_HEAP_INIT_SLOTS=1650000
export RUBY_HEAP_FREE_MIN=200000
export RUBY_HEAP_SLOTS_INCREMENT=300000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=189000000

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
alias gpr='g pull --rebase'
alias gs='g status'
alias gc='g checkout'
alias gm='g commit -m'
alias gd='g diff'
alias gb='g branch'
GIT_EDITOR="vim"

#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE="en_US.UTF-8"
export TERM=xterm-256color
# Path
export PATH="/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/sbin:/Users/Kevin/Library/Scripts/Shell:/usr/local/mysql/bin:/Users/kevin/.bin:/Users/Kevin/Development/Cerego/bin:/usr/local/share/npm/bin:$PATH"

## Prompt ##
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PS1="\W | $(~/.rvm/bin/rvm-prompt) \@ \$(parse_git_branch)始 "
