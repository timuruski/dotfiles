# Use to set and invert Base16 colorscheme.
# Depends on: https://github.com/chriskempson/base16-shell

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
