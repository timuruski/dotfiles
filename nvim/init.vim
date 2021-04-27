set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

" Use block cursor for everything.
set guicursor=a:block-blinkon50

" Highlight matches for substitution
set inccommand=nosplit
