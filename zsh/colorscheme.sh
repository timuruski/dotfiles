# Use to set and invert Base16 colorscheme.
# Depends on: https://github.com/chriskempson/base16-shell

function set-colors {
  BASE16_SHELL="$1"
  [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
  export BASE16_SHELL
}

function invert-colors {
  case "${BASE16_SHELL}" in
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

  BASE16_SHELL="$(echo $BASE16_SHELL | sed -e "s/${FROM_COLOR}/${TO_COLOR}/")"
  set-colors $BASE16_SHELL
}

set-colors $COLORSCHEME
