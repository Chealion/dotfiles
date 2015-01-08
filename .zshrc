#Housekeeping
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000
setopt appendhistory inc_append_history share_history hist_ignore_dups extended_history autocd extendedglob
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:~/ShellScripts:/usr/local/Cellar/go/1.4/libexec/bin:~/Documents/go/bin:/usr/libexec

export GOPATH=~/Documents/go

#Default ZSH apps
EDITOR='/usr/bin/vim'
PAGER="less"

#Prompt
export PS1='micheal@%~ %# '

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
alias j=jobs
alias ls="ls -GF"
alias ll="ls -l"
alias top="top -u"
alias lsa="ls -laFh"
alias cd..='cd ..'
alias ..='cd ..'
alias tsl="tail -f /var/log/syslog"
export VPN_USERNAME='micheal.jones'
alias cyberavpn="~/src/cybera/lmc.git/bin/lmc vpn"

#Tools
alias chromeupdate='~/ShellScripts/chromium.sh'
alias ffmpegrewrap='/usr/local/bin/ffmpeg -i "$1" -acodec pcm_s16le -vcodec copy "$2".mov'

function memh() {
    top -n 5 -o rprvt -l1 -stats pid,command,rprvt | tail -n 5;
}

function dialog() {
    osascript -e "tell application \"Finder\"" -e "activate" -e "display dialog \"$1\"" -e "end tell"
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

#Login Information To Write
if [[ $TERM == "xterm-color" ]]; then
    date
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
