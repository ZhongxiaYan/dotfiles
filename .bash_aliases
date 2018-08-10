alias tmux='TERM=xterm-256color tmux'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias mkdir="mkdir -pv"
alias cp="cp -r"
alias ..="cd .."
alias ...="cd ../.."
alias .4="cd ../../../.."

alias downloads="cd ~/Downloads"
alias desktop="cd ~/Desktop"
alias documents="cd ~/Documents"
alias db="cd ~/Dropbox"

# Create a new directory and enter it
function mk() {
    mkdir -p "$@" && cd "$@"
}

alias yosef_notebook="ssh -N -L localhost:8887:localhost:8887 yosef"

#   "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s
/[;&|]\s*alert$//'\'')"'

