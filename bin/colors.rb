#! /usr/bin/env ruby

CODES = {
  reset: "\e[0m",
  n: { red:    "\e[0;31m",
       green:  "\e[0;32m",
       yellow: "\e[0;33m",
       blue:   "\e[0;34m",
       purple: "\e[0;35m",
       cyan:   "\e[0;36m",
       white:  "\e[0;37m" },
  b: { red:    "\e[1;31m",
       green:  "\e[1;32m",
       yellow: "\e[1;33m",
       blue:   "\e[1;34m",
       purple: "\e[1;35m",
       cyan:   "\e[1;36m",
       white:  "\e[1;37m" },
  u: { red:    "\e[4;31m",
       green:  "\e[4;32m",
       yellow: "\e[4;33m",
       blue:   "\e[4;34m",
       purple: "\e[4;35m",
       cyan:   "\e[4;36m",
       white:  "\e[4;37m" },
  bg: { black:  "\e[40m",
        red:    "\e[41m",
        green:  "\e[42m",
        yellow: "\e[43m",
        blue:   "\e[44m",
        purple: "\e[45m",
        cyan:   "\e[46m",
        white:  "\e[47m" }
}

RESET = "\e[0m"

def reset
  RESET
end

alias :r :reset

def c(*args)
  return COLORS[:n][args[0]] if args.length == 1

  str, color = *args
  color = COLORS[:n][color]

  "#{color}#{str}#{reset}"
end

def b(*args)
  return COLORS[:b][:white] if args.length == 0
  return COLORS[:b][args[0]] if args.length == 1

  str, color = *args
  color = COLORS[:b][color]

  "#{color}#{str}#{reset}"
end

def u(*args)
  return COLORS[:u][:white] if args.length == 0
  return COLORS[:u][args[0]] if args.length == 1

  str, color = *args
  color = COLORS[:u][color]

  "#{color}#{str}#{reset}"
end

def bg(*args)
  return COLORS[:bg][args[0]] if args.length == 1

  str, color = *args
  color = COLORS[:bg][color]

  "#{color}#{str}#{reset}"
end


# txtblk='\e[0;30m' # Black - Regular
# txtred='\e[0;31m' # Red
# txtgrn='\e[0;32m' # Green
# txtylw='\e[0;33m' # Yellow
# txtblu='\e[0;34m' # Blue
# txtpur='\e[0;35m' # Purple
# txtcyn='\e[0;36m' # Cyan
# txtwht='\e[0;37m' # White
# bldblk='\e[1;30m' # Black - Bold
# bldred='\e[1;31m' # Red
# bldgrn='\e[1;32m' # Green
# bldylw='\e[1;33m' # Yellow
# bldblu='\e[1;34m' # Blue
# bldpur='\e[1;35m' # Purple
# bldcyn='\e[1;36m' # Cyan
# bldwht='\e[1;37m' # White
# unkblk='\e[4;30m' # Black - Underline
# undred='\e[4;31m' # Red
# undgrn='\e[4;32m' # Green
# undylw='\e[4;33m' # Yellow
# undblu='\e[4;34m' # Blue
# undpur='\e[4;35m' # Purple
# undcyn='\e[4;36m' # Cyan
# undwht='\e[4;37m' # White
# bakblk='\e[40m'   # Black - Background
# bakred='\e[41m'   # Red
# bakgrn='\e[42m'   # Green
# bakylw='\e[43m'   # Yellow
# bakblu='\e[44m'   # Blue
# bakpur='\e[45m'   # Purple
# bakcyn='\e[46m'   # Cyan
# bakwht='\e[47m'   # White
# txtrst='\e[0m'    # Text Reset

