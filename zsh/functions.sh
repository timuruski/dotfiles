function reload { source $HOME/.zshenv; source $ZDOTDIR/.zshrc }
function mkcd { mkdir -p "$1" && cd "$1" }
alias mcd=mkcd

# Connect to a TMDB server via jump host.
# Requires bootstratp_id credentials in ~/.ssh/config:
function jssh {
  ssh -J ec2-user@jump.tmdb0.themoviedb.com ec2-user@${1} ${@:2};
}

function lbundle {
  export BUNDLE_GEMFILE=Gemfile.local
  bundle config set gemfile Gemfile.local
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

function tpath {
  local p="${1##views/}"
  echo "${p%%.erb}"
}
