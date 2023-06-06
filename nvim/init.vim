set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

" Somethimg in neovim is remapping Y to y$ :shrug:
nmap Y <nop>
nunmap Y

" Ignore jumping to ctag definition, it collides with <c-[> too easily.
nnoremap <C-]> <nop>

" Skip ;2u when shift key is sticky.
tnoremap <S-Space> <space>

" Use block cursor for everything.
set guicursor=a:block-blinkon50

" Disable mouse junk
set mouse=

" Highlight matches for substitution
set inccommand=nosplit

" Break out of insert mode for terminal views, for vim-test.
let test#strategy = "neovim"
let g:test#basic#start_normal = 1
let g:test#neovim#start_normal = 1

" This breaks FZF integration.
" tnoremap <Esc> <C-\><C-n>
