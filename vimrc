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

" Show routes
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Put routes output into buffer
  :0r! rake -s routes
  " Size window to number of lines (output length + 1)
  :exec ":normal " . line("$") . "^W_"
  " Move cursor to the bottom
  :normal 1GG
  "Delete empty trailing line
  :normal dd
endfunction

" Adapted from @garybernhardt
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<\(controllers\|models\|views\|helpers\|decorators\|services\)\>') != -1 
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction

nnoremap <leader>. :call OpenTestAlternate()<cr>

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    call ClearScreen()
    if match(a:filename, '\.feature$') != -1
      if filereadable("script/features")
        exec ":!script/features " . a:filename
      else
        exec ":!cucumber " . a:filename
      end
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! ClearScreen()
    " Print enough lines to clear the screen
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
" map <leader>a :call RunTests('')<cr>


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


" Visual search
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

