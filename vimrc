" Tim Uruski's amazing Vim configuration, mixes minimalism with
" ideas from Gary Bernhardt and Tim Pope.

" Don't worry about compatibility with original Vi
set nocompatible

" Vimplug
call plug#begin('~/.vim/plugged')

Plug 'csexton/trailertrash.vim'
Plug 'janko-m/vim-test'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
" Plug 'tpope/vim-rails', { 'for': 'ruby' }
" Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/ag.vim'
Plug 'vim-utils/vim-man'
Plug 'vimwiki/vimwiki'
" Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" Syntax
Plug 'vim-scripts/SyntaxAttr.vim'
" Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'

call plug#end()

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
set relativenumber " May be causing slowdown...
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
" autocmd FileType ruby setlocal norelativenumber nocursorline regexpengine=1


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
nnoremap <C-l> :nohlsearch<CR>
" nnoremap <CR> :nohlsearch<cr>

" Toggle relative line numbers
nnoremap <F1> :set relativenumber!<CR>

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
let g:airline#extensions#branch#enabled = 0
let g:airline_theme = 'minimalist'
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
" Count matches for word under cursor...?
xnoremap <leader>* *<C-O>:%s///gn<CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" General purpose command to run when the <enter> key is pressed.
" RunCmd! rake
" RunCmd rake task
" RunCmd ruby -Ilib %
" RunTest


" command! -bang RunCmd nnoremap <enter> call s:runcmd(<qargs>, <bang>)
command! -nargs=+ RunRunCmd nnoremap <enter> :w \| !clear; <args> <CR>
command! -nargs=1 RunCmd nnoremap <buffer> <enter> :w \| !clear; <args> % <CR>
command! -nargs=+ RunCmd nnoremap <buffer> <enter> :w \| !clear; <args> <CR>
command! -nargs=0 RunRuby nnoremap <buffer> <enter> :w \| !clear; ruby % <CR>
command! -nargs=0 RunMake nnoremap <buffer> <enter> :w \| make! <CR>
command! -nargs=* RunMake nnoremap <buffer> <enter> :w \| make! <args> <CR>
command! -nargs=0 WriteCmd nnoremap <buffer> <enter> :w <args> <CR>

command! -nargs=0 RunTest nnoremap <buffer> <enter> :w \| :TestFile <CR>
" command! -nargs=0 RunTest! nnoremap <enter> :w \| :TestFile <CR>
" command! RunTest nnoremap <buffer> <enter> call RunCmd() <CR>


function! s:runcmd()
  " Command name
  " Command args
  " Command bang
  " Buffer reference?
  " - write
  " - clear terminal
  " - execute command
  " - maybe press <enter>
  echom "runcmd"
  execute(":write")
endfunction

" FZF
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'CursorLine'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Normal'],
  \ 'info':    ['fg', 'Normal'],
  \ 'prompt':  ['fg', 'Normal'],
  \ 'pointer': ['fg', 'Normal'],
  \ 'marker':  ['fg', 'Normal'],
  \ 'spinner': ['fg', 'Normal'],
  \ 'header':  ['fg', 'Normal'] }

" Visual style
" set t_Co=256
set colorcolumn=100
set hlsearch
let base16colorspace=256
let &background=substitute(expand("$COLORSCHEME"), '\v.*(light|dark).*', '\1', '')
colorscheme eink

" Syntax highlighting
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" command! -nargs=1 SynStack nnoremap <buffer> <enter> :w \| !clear; <args> % <CR>

map <leader>gc :Files components/manage/app/controllers<CR>
map <leader>gC :Files components/manage/app/assets/stylesheets<CR>
map <leader>gh :Files components/manage/app/helpers<CR>
map <leader>gj :Files components/manage/client-src<CR>
map <leader>gm :Files components/manage/app/models<CR>
" map <leader>gs :Files spec<CR>
" map <leader>gS :Files app/services<CR>
map <leader>gv :Files components/manage/app/views<CR>

map <leader>gM :topleft 100 :sview db/schema.rb<CR>
map <leader>gg :topleft 100 :split Gemfile<CR>
" map <leader>gt :CtrlPClearCache<CR>\|:CtrlPTag<CR>
map <leader>gr :topleft :split config/routes.rb<CR>
map <leader>gR :call ShowRoutes()<CR>
map <leader>b :Buffers<CR>
map <leader>f :Files<CR>
map <leader>F :Files %%<CR>

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

" Configure Ale
if exists('g:loaded_ale') && g:loaded_ale
  " let g:ale_linters = {'ruby': ['standardrb']}
  " let g:ale_fixers = {'ruby': ['standardrb']}
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_fix_on_save = 1
endif

" VimWiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" let g:syntastic_typescript_checkers = ['tslint', 'tsc']
" let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint --type-check']

" https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Disable bracketed paste mode
" https://groups.google.com/forum/#!searchin/vim_dev/%3CPasteStart%3E%7Csort:relevance/vim_dev/eP3GUBqzgGA/zpj0r4ztCgAJ
" set t_BD=false
