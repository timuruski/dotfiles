# Use to set and invert Base16 colorscheme.
# Depends on: https://github.com/chriskempson/base16-shell

function base16 {
  local base16_dir="$HOME/.zsh/base16-shell"
  local background=$(echo $COLORSCHEME | sed -E "s/.*(light|dark).*/\1/")

  if [[ $# > 0 ]]; then
    COLORSCHEME="$base16_dir/base16-$1.$background.sh"
    colorscheme $COLORSCHEME
  else
    find $base16_dir -name "base16-*.light.sh" | \
      sed -E "s/.*base16-([^.]*).*\.sh/\1/"
  fi
}

function colorscheme {
  COLORSCHEME="$1"
  [[ -s $COLORSCHEME ]] && source $COLORSCHEME
  export COLORSCHEME
}

function invert-colors {
  case "${COLORSCHEME}" in
    *light.sh )
      FROM_COLOR="light"
      TO_COLOR="dark"
      ;;
    *dark.sh  )
      FROM_COLOR="dark"
      TO_COLOR="light"
      ;;
    * )
      exit
      ;;
  esac

  COLORSCHEME="$(echo $COLORSCHEME | sed -e "s/${FROM_COLOR}/${TO_COLOR}/")"
  colorscheme $COLORSCHEME
}
