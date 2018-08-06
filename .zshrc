#Housekeeping
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000
setopt appendhistory inc_append_history share_history hist_ignore_dups extended_history autocd extendedglob
export PATH=$PATH:~/Documents/go/bin:/usr/libexec

export GOPATH=~/Documents/go

#Default ZSH apps
EDITOR='/usr/bin/vim'
PAGER="less"

#macOS Sierra Hack to add keys using Keychain stored password
if [[ $(ssh-add -l | wc -l) -ne 3 ]]; then
  ssh-add -K
  ssh-add -K ~/.ssh/cyberaMenlo
  ssh-add -K ~/.ssh/mcjones_25519
fi  

#Prompt
export PS1='micheal@%~ %# '

#function title() {
  # escape '%' chars in $1, make nonprintables visible
#  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
#  a=$(print -Pn "%40>...>$a" | tr -d "\n")

#  case $TERM in
#  screen)
#    print -Pn "\ek$a:$3\e\\"      # screen title (in ^A")
#    ;;
#  xterm*|rxvt)
#    print -Pn "\e]2;$2 | $a:$3\a" # plain xterm title
#    ;;
#  esac
#}

# precmd is called just before the prompt is printed
#function precmd() {
#  title "zsh" "$USER@%m" "%55<...<%~"
#}

# preexec is called just before any command line is executed
#function preexec() {
#  title "$1" "$USER@%m" "%35<...<%~"
#}

# colorful listings
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -U compinit
compinit

bindkey "^[[3~" delete-char
bindkey '^R' history-incremental-search-backward

# aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias lsa="ls -laFh"
alias cd..='cd ..'
alias ..='cd ..'
alias tsl="tail -f /var/log/syslog"

#Work aliases
alias ip2="curl -6 icanhazip.com; curl -4 icanhazip.com"
alias noval='nova list --fields name,status,power_state,networks,metadata'

#Tools
alias ffmpegrewrap='/usr/local/bin/ffmpeg -i "$1" -acodec pcm_s16le -vcodec copy "$2".mov'

alias fuckyousandcloud='source ~/openstack_rcs/sandcloud/sandcloud.sh; nova reboot --hard oncall;'

# functions
quick14() { nova boot --image "Ubuntu 14.04" --flavor m1.small --key-name cyberaMenlo "$1" --poll }
quick16() { nova boot --image "Ubuntu 16.04" --flavor m1.small --key-name cyberaMenlo "$1" --poll; nova show "$1" | grep metadata}
nsh() { nova ssh --address-type fixed --ipv6 --login ubuntu "$1" }
mdc() { mkdir -p "$1" && cd "$1" }
setenv() { export $1=$2 }  # csh compatibility
sdate() { date +%Y.%m.%d }
pc() { awk "{print \$$1}" }
rot13 () { tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" }

function memh() {
    top -n 5 -o rprvt -l1 -stats pid,command,rprvt | tail -n 5;
}

function bkdate() {
    #cp $1 {{, .`date +%Y%m%d`}};
}

function dialog() {
    osascript -e "tell application \"System Events\"" -e "activate" -e "display dialog \"$1\"" -e "end tell"
}

function rgit() {
    git rev-list --abbrev-commit HEAD . |wc -l|awk '{print $1}'
}

function batteryCharge() {
    ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%.2f%%", $10/$5 * 100)}'
}

function fileHandleCount() {
    ps -e|grep -v TTY|awk {'print "lsof -p "$1"|wc -l"'} > /tmp/a.out; chmod 755 /tmp/a.out; /tmp/a.out > /tmp/fh; awk '{s+=$1} END {print s}' /tmp/fh; rm /tmp/a.out; rm /tmp/fh;
}

function dock() {
  eval $(docker-machine env $1)
}

function undock() {
  unset DOCKER_HOST
  unset DOCKER_MACHINE_NAME
  unset DOCKER_TLS_VERIFY
  unset DOCKER_CERT_PATH
}

function oscurl() {
  token=$(openstack token issue -c id -f value)
  curl -s -H "X-Auth-Token:$token" $1
}

function os_clean { unset OS_AUTH_URL OS_TENANT_NAME OS_USERNAME OS_PASSWORD OS_REGION_NAME OS_PROJECT_NAME OS_PROJECT_DOMAIN_NAME OS_USER_DOMAIN_NAME OS_IDENTITY_AI_VERSION; }

#Login Information To Write
if [[ $TERM == "xterm-color" ]]; then
    date
fi

