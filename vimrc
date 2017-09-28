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
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'vim-scripts/ag.vim'
Plug 'vim-utils/vim-man'
Plug 'leafgarland/typescript-vim'

call plug#end()

" Semi-universal <ESC> alternatives
inoremap jk <ESC>
inoremap kj <ESC>

" Quick access to vim config
nnoremap <leader>ev :edit $MYVIMRC<cr>
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
set textwidth=110

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

command! -nargs=1 RunCmd nnoremap <buffer> <enter> :w \| !clear; <args> % <CR>
command! -nargs=+ RunCmd nnoremap <buffer> <enter> :w \| !clear; <args> <CR>
command! -nargs=0 RunRuby nnoremap <buffer> <enter> :w \| !clear; ruby % <CR>
command! -nargs=0 RunMake nnoremap <buffer> <enter> :w \| make! <CR>
command! -nargs=* RunMake nnoremap <buffer> <enter> :w \| make! <args> <CR>
command! -nargs=0 WriteCmd nnoremap <buffer> <enter> :w <args> <CR>

command! -nargs=0 RunTest nnoremap <buffer> <enter> :w \| :TestFile <CR>
" command! -nargs=0 RunTest! nnoremap <enter> :w \| :TestFile <CR>
" command! RunTest nnoremap <buffer> <enter> call RunCmd() <CR>


function! s:RunCmd()
  " Command name
  " Command args
  " Buffer reference?
  " - write
  " - clear terminal
  " - execute command
  " - maybe press <enter>
  echom "RunCmd"
endfunction

" FZF
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Visual style
" set t_Co=256
set colorcolumn=110
set hlsearch
let base16colorspace=256
let &background=substitute(expand("$COLORSCHEME"), '\v.*(light|dark).*', '\1', '')
colorscheme base16

map <leader>gm :Files app/models<cr>
map <leader>gv :Files app/views<cr>
map <leader>gc :Files app/controllers<cr>
map <leader>gh :Files app/helpers<cr>
map <leader>gs :Files spec<cr>
map <leader>gp :Files app/presenters<cr>
map <leader>gS :Files app/services<cr>
map <leader>gl :Files lib<cr>
map <leader>gC :Files app/assets/stylesheets<cr>
map <leader>gJ :Files app/assets/javascripts<cr>

map <leader>gM :topleft 100 :sview db/schema.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
" map <leader>gt :CtrlPClearCache<cr>\|:CtrlPTag<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gR :call ShowRoutes()<cr>
map <leader>b :Buffers<cr>
map <leader>f :Files<cr>
map <leader>F :Files %%<cr>

let g:ctrlp_map = '<leader>f'
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](\.gem|node_modules|vendor|build)$',
      \ }

" Toggle background
nmap <F2> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Examine path
command! Path :echo join(split(&path, ","), "\n")

" GitHub Path command
command! Gurl :echo !(echo "https://github.com/Clio/") . expand("%")

" Direnv integration
" https://github.com/direnv/direnv/wiki/Vim
if exists("$EXTRA_VIM")
  for path in split($EXTRA_VIM, ':')
    exec "source ".path
  endfor
endif

" Disable bracketed paste mode
" https://groups.google.com/forum/#!searchin/vim_dev/%3CPasteStart%3E%7Csort:relevance/vim_dev/eP3GUBqzgGA/zpj0r4ztCgAJ
" set t_BD=false
