function reload { source $HOME/.zshenv; source $ZDOTDIR/.zshrc }
function mkcd { mkdir -p "$1" && cd "$1" }
alias mcd=mkcd
