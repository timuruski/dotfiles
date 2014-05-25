" Tim Uruski's amazing Vim configuration, mixes minimalism with
" ideas from Gary Bernhardt and Tim Pope.

" Don't worry about compatibility with original Vi
set nocompatible

" Pathogen plugins
execute pathogen#infect()
execute pathogen#helptags()

" Semi-universal <ESC> alternatives
inoremap jk <ESC>
inoremap kj <ESC>


" Some setups need this, not sure which though.
set shell=/bin/sh

" Sensible leader shortcut
let mapleader=","
let maplocalleader=","
let g:mapleader=","
let g:maplocalleader=","

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
set modelines=0
set relativenumber
set number
set ruler
set showmatch
set smartcase
set wildmenu
set wildmode=longest,list

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
set textwidth=72

" Window sizing rules from @garybernhardt
set winwidth=84
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

" Hashrocket expansion =>
inoremap <c-l> <space>=><space>

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

" Matchit functionality
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

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

command! -nargs=0 RunRuby nnoremap <leader>r :w \| !ruby %<cr>

" Visual style
" set t_Co=256
set colorcolumn=72
set hlsearch
set background=light
colorscheme base16

