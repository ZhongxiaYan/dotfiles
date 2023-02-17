shopt -s nullglob dotglob

alias tmux='TERM=xterm-256color tmux'

if [ "$(uname)" == "Darwin" ]; then
    alias ls='ls -FG'
    alias ll='ls -alFG'
    alias la='ls -AFG'
    alias l='ls -CFG'
    export LSCOLORS='ExfxbEaEBxxEhEhBaDaCaD'
    export GREP_OPTIONS='--color=auto'
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
alias lll='ll -tr'

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

function mkdircp {
    src=$1
    dst=$2
    if [[ "$2" == *"/"* ]]; then
        dst=`basename $dst`
    fi
    mkdir -p $dst
    cp -r $src $dst
}

function mkcp {
    src=$1
    dst=$2
    if [[ "$2" == *"/"* ]]; then
        dst=`basename $dst`
    fi
    mkdir -p $dst
    cp -r $src $dst
    cd $dst
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

function rmexcept() {
    files=(*)
    rmfiles=($(comm -13 <(printf "%s\n" "${@}" | sort) <(printf "%s\n" "${files[@]}" | sort)))
    for name in "${rmfiles[@]}"
    do
        rm -r "$name"
    done
}

function mvall() {
    target="${@: -1}"
    for name in "${@:1:${#@}-1}"
    do
        mv $name $target
    done
}

function cpall() {
    target="${@: -1}"
    for name in "${@:1:${#@}-1}"
    do
        cp $name $target
    done
}

alias rm_pwd='OLD_PWD=$(pwd); cd ..; rm -rf $OLD_PWD'
alias dpython='python -m pdb -c continue'
alias dvpython='python -m pudb -c continue'
alias pd=pushd # when pushing, can use cd~0 to go to last on stack, also cd~1 and etc

alias cdn='cd "$(ls -1dt ./*/ | head -n 1)"' # cd newest child directory
alias cdf='cd $(ls -d */|head -n 1)' # cd first alphabetical child directory
alias cdl='cd $(ls -d */|tail -n 1)' # cd last alphabetical child directory

