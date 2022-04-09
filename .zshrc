bindkey '[C' forward-word
bindkey '[D' backward-word
bindkey '^D' kill-word

backward-delete-dir() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N backward-delete-dir
bindkey '^B' backward-delete-dir
