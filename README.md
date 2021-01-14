# ~timuruski

## Installation
Files are symlinked into the user home directory with `.` prefix.
The installer script defines a list of paths to ignore, etc.

`./install.rb`

## Todo:
- Install each bin separately instead of symlinking the bin directory


## Interesting plugins
* [CtrlP](https://github.com/kien/ctrlp.vim) - Fuzzy file finder written in VimScript
* [Source](https://github.com/suderman/source.vim) - Alternative to
  pathogen
* [simplenote.vim](https://github.com/mrtazz/simplenote.vim) - Simplenote web service
* [vim-pasta](https://github.com/sickill/vim-pasta) - context-aware pasting
* [vim-smartinput](https://github.com/kana/vim-smartinput) - smarter punctuation pairs
* [numbers.vim](https://github.com/myusuf3/numbers.vim) - Switches
  between relative and absolute numbers based on mode.

## Interesting ideas
* [OS X defaults](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)
* [Autoenv](https://github.com/kennethreitz/autoenv)
* [direnv](https://github.com/zimbatm/direnv)

## Replaceing dotfile paths
Originally I installed into ~/.dotfiles, but it's clunky, here's the transition.

  ls -a | awk '/\.dotfiles/ { dotfile = $9; sub("^\.", "", dotfile); print "ln -fs ~/workspace/dotfiles/" dotfile " ~/." dotfile }'
