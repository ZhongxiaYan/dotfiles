alias tmux='TERM=xterm-256color tmux'

if [ "$(uname)" == "Darwin" ]; then
    alias ls='ls -FG'
    alias ll='ls -alFG'
    alias la='ls -AFG'
    alias l='ls -CFG'
    export GREP_OPTIONS='--color=always'
    export GREP_COLOR='1;35;40'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    alias ls='ls --color=auto -F'
    alias ll='ls --color=auto -alF'
    alias la='ls --color=auto -AF'
    alias l='ls --color=auto -CF'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias mkdir="mkdir -pv"
alias cp="cp -r"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias df="df -Tha --total"
alias du="du -sh"
alias free="free -mt"
alias ps="ps aux"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias wget="wget -c"
alias myip="curl http://ipecho.net/plain; echo"

# Create a new directory and enter it
function mk() {
    mkdir -p "$@" && cd "$@"
}

#   "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s
/[;&|]\s*alert$//'\'')"'

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

function port() {
    remote=${2:-8888}
    local=${3:-"$remote"}
    ssh -N -L "localhost:$local:localhost:$remote" $1
}

function rn() {
    src=$(basename $(pwd))
    cd ..
    mv $src $1
    cd $1
}

function v() {
    if [ -d "$1" ] ; then
        ls $1 ;
    else
        cat $1;
    fi
}

function vv() {
    if [ -d "$1" ] ; then
        ls $1 ;
    else
        vim $1;
    fi
}

alias rm_pwd='OLD_PWD=$(pwd); cd ..; rm -rf $OLD_PWD'
