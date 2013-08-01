" Tim Uruski's amazing Vim configuration, mixes minimalism with
" ideas from Gary Bernhardt and Tim Pope.

" Don't worry about compatibility with original Vi
set nocompatible

" Pathogen plugins
execute pathogen#infect()
execute pathogen#helptags()


" Sensible leader shortcut
" let mapleader="\<space\>"
" let g:mapleader="\<space\>"
let mapleader=","
let g:mapleader=","

" Quick access to vim config
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>


" SETTINGS
" ================================

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" For some reason rbenv's doesn't work without this
set shell=/bin/sh

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
set ruler
set showmatch
set smartcase
set wildmenu
set wildmode=longest,list

" Visual style
set t_Co=256
set background=dark
colorscheme timuruski-dark
set colorcolumn=80
set cursorline
set hlsearch

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

" Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_mode_n = ' N '
let g:Powerline_mode_i = ' I '
let g:Powerline_mode_v = ' V '
let g:Powerline_mode_V = ' VL '
let g:Powerline_mode_cv = ' VB '
let g:Powerline_mode_s = ' S '
let g:Powerline_mode_S = 'SL '
let g:Powerline_mode_cs = ' SB '

" Airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme = 'luna'
let g:airline_mode_map = {
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'v'  : 'V',
  \ 'V'  : 'VL',
  \ '' : 'VB',
  \ 'c'  : 'C' }


" Command-T
set wildignore=vendor/**,tmp/**,bin/**
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gd :CommandTFlush<cr>\|:CommandT app/decorators<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT app/services<cr>
map <leader>gM :topleft 100 :sview db/schema.rb<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gS :CommandTFlush<cr>\|:CommandT app/assets/stylesheets<cr>
map <leader>gJ :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gR :call ShowRoutes()<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>
" Map <esc> to close Command-T window
let g:CommandTCancelMap=['<C-c>', '<esc>']


" Unite
let g:unite_enable_start_insert=1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#set_profile('files', 'smartcase', 1)

function! UniteCommandT(dir)
  :Unite -toggle -auto-resize -buffer-name=a:dir -input=a:dir file_rec/async
endfunction

nmap <space> [unite]
nnoremap [unite] <nop>
nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]gv :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
" nnoremap <silent> [unite]gm :call UniteCommandT('app/models')<cr><c-u>
" nnoremap <silent> [unite]gc :call UniteCommandT('app/controllers')<cr><c-u>
" nnoremap <silent> [unite]gh :call UniteCommandT('app/helpers')<cr><c-u>
" nnoremap <silent> [unite]gv :call UniteCommandT('app/views')<cr><c-u>
nnoremap <silent> [unite]gm :<C-u>Unite -toggle -auto-resize -input=app/models -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> [unite]gc :<C-u>Unite -toggle -auto-resize -input=app/controllers -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> [unite]gh :<C-u>Unite -toggle -auto-resize -input=app/helpers -buffer-name=files file_rec/async<cr><c-u>
nnoremap <silent> [unite]gv :<C-u>Unite -toggle -auto-resize -input=app/views -buffer-name=files file_rec/async<cr><c-u>


autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.
  nmap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <S-TAB>   <Plug>(unite_select_previous_line)
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)

  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
  " nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  " imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
endfunction


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

