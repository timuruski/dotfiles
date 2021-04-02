function reload { source $ZDOTDIR/.zshrc }
function mkcd { mkdir -p "$1" && cd "$1" }
alias mcd=mkcd
