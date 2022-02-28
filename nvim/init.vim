set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

" Somethimg in neovim is remapping Y to y$ :shrug:
nunmap Y

" Use block cursor for everything.
set guicursor=a:block-blinkon50

" Highlight matches for substitution
set inccommand=nosplit

" Break out of insert mode for terminal views, for vim-test.
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif
