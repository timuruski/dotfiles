function reload { source $HOME/.zshenv; source $ZDOTDIR/.zshrc }
function mkcd { mkdir -p "$1" && cd "$1" }
alias mcd=mkcd

function lbundle {
  export BUNDLE_GEMFILE=Gemfile.local
  bundle config gemfile Gemfile.local
  if [ $# -gt 0 ]; then
    bundle $@
  # else
  #   bundle
  fi
}

function rbundle {
  unset BUNDLE_GEMFILE
  bundle config unset gemfile
  if [ $# -gt 0 ]; then
    bundle $@
  # else
  #   bundle
  fi
}
