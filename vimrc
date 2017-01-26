" Tim Uruski's amazing Vim configuration, mixes minimalism with
" ideas from Gary Bernhardt and Tim Pope.

" Don't worry about compatibility with original Vi
set nocompatible

" Vimplug
call plug#begin('~/.vim/plugged')

" Plug 'scrooloose/syntastic'
Plug 'csexton/trailertrash.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'janko-m/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'vim-scripts/ag.vim'

call plug#end()

" Semi-universal <ESC> alternatives
inoremap jk <ESC>
inoremap kj <ESC>

" Quick access to vim config
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Enable project specific vimrc files
set exrc
set secure

" TCSH style commandline editing
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <C-X> <C-F>

" Matchit functionality
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif


" SETTINGS
" ================================

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Big bucket of settings.
set autoread
set backspace=indent,eol,start
set hidden
set history=1000
set incsearch
set ignorecase
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set matchtime=2
set modelines=0
set relativenumber
set number
set ruler
set showmatch
set smartcase
set wildmenu
set wildmode=longest,list
set wildignore=*.otf,*.eot*.woff,*.ttf,*/.gem/*,*/vendor/*,*/tmp/*


" Text formatting
syntax on
filetype on
filetype indent on
filetype plugin on
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set textwidth=80

" Window sizing rules from @garybernhardt
" set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999


" AUTOCOMMANDS
" ================================

" Disable backups when editing a temp file, usually because it's a
" crontab file, and cron gets upset when a backup is written.
autocmd BufRead /tmp/*		set nowritebackup



" MAPPINGS AND FUNCTIONS
" ================================

" Disable ex mode until you know how to use it.
nmap Q <Nop>

" Disable weird effect when Ctrl-Space is pressed in Insert mode.
imap <Nul> <Space>

" Shortcut to directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Open file in same directory as current file
map <leader>e :edit %%
nnoremap <leader><leader> <C-^>

" Clear search highlighting
nnoremap <C-l> :nohlsearch<cr>
" nnoremap <CR> :nohlsearch<cr>

" Smarter tab behavior from @garybernhardt
" Indents at start of line, otherwise completes, or matches parens
function!  InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
   return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
" *noremap here doesn't work because % is an expression
" These interfere with <C-i> and jumps.
" nmap <tab> %
" vmap <tab> %

" Rename current file from @garybernhardt
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        exec ':bdelete ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" CONFIGURATION
" ================================

" Netrw
let g:netrw_liststyle = 3
let g:netrw_altv = 1

" Airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme = 'base16'
let g:airline_mode_map = {
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'v'  : 'V',
  \ 'V'  : 'VL',
  \ '' : 'VB',
  \ 'c'  : 'C' }

" Vimroom
let g:vimroom_background = 'white'
let g:vimroom_sidebar_height = 0


" QuickFix to args
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction


" Visual search
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

command! -nargs=0 RunMake nnoremap <leader>r :w \| !clear; make<cr>
command! -nargs=0 RunRuby nnoremap <leader>r :w \| !clear; ruby %<cr>
command! -nargs=1 RunCmd nnoremap <leader>r :w \| !clear; <args> % <CR>

" Visual style
" set t_Co=256
set colorcolumn=80
set hlsearch
let base16colorspace=256
let &background=substitute(expand("$COLORSCHEME"), '\v.*(light|dark).*', '\1', '')
colorscheme base16

" Toggle background
nmap <F2> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Disable bracketed paste mode
" https://groups.google.com/forum/#!searchin/vim_dev/%3CPasteStart%3E%7Csort:relevance/vim_dev/eP3GUBqzgGA/zpj0r4ztCgAJ
set t_BD=false
