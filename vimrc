" A lot of this file is based on Gary Bernhardt's dotfiles.
" https://github.com/garybernhardt/dotfiles/tree/master/.vim

" Invoke pathogen - https://github.com/tpope/vim-pathogen
call pathogen#infect()
call pathogen#helptags()

" Set the default shell, maybe fixes RVM?
set shell=/bin/sh

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Disable modelines for security
set modelines=0

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Remember more commands and search history
set history=1000

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Enable plugins for filetypes
filetype plugin on

" map Shift + Return to Esc in Insert mode
inoremap jj <Esc>
inoremap kj <Esc>
" These don't map for all terminals, since Shift + Enter isn't sent
noremap <S-CR> <Esc>
inoremap <S-CR> <Esc>

if has("vms")
  set nobackup  " do not keep a backup file, use versions instead
else
  set backup  " keep a backup file
endif
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set list
set listchars=tab:▸\ ,eol:¬,trail:·

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

abbreviate emd end
abbreviate enf end

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
" set smartindent
set laststatus=2
set tabline=2
set showmatch
set incsearch
set wrap
set linebreak
" set number
set relativenumber
set textwidth=72
set colorcolumn=80

" Highlight search
set hls

" GRB: use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" Shortcut to directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Remap leader and other TextMate-like shortcuts
let mapleader=","
nnoremap <leader><leader> <c-^>
imap <c-l> <space>=><space>
nnoremap <tab> %
vnoremap <tab> %
" nnoremap ; :
" re-hardwrap paragraphs of text, like TextMate Ctrl + q
nnoremap <leader>q gqip
" shortcut to map ,r to whatever
nnoremap <leader>r :nnoremap <leader>r :w \\| 

" Help is already easy to get via :h
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" <space> is useless
nmap <space> zz
nmap n nzz
nmap N Nzz

" Don't use Ex mode, use Q for formatting
map Q gq

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Open files in directory of the current file
map <leader>e :edit %%
map <leader>v :view %%
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

"
" Command-T mappings
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

map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gd :CommandTFlush<cr>\|:CommandT app/decorators<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT app/services<cr>
map <leader>gM :topleft 100 :sview db/schema.rb<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gS :CommandTFlush<cr>\|:CommandT public/stylesheets<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gR :call ShowRoutes()<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

" Map <esc> to close Command-T window
let g:CommandTCancelMap=['<C-c>', '<esc>']
"
" Configure Command-t
set wildignore=vendor/bundle/**,vendor/ruby/**,tmp/**


" Smart tab key
" Indents at start of line, otherwise completes
" As stolen from GRB.vimrc
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Running tests
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
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
map <leader>a :call RunTests('')<cr>
map <leader>c :w\|:!script/features<cr>
map <leader>w :w\|:!script/features --profile wip<cr>


" highlight current line
set cursorline

" Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_mode_n = ' N '
let g:Powerline_mode_i = ' I '
let g:Powerline_mode_v = ' V '
let g:Powerline_mode_V = ' VL '
let g:Powerline_mode_cv = ' VB '

" Don't show scroll bars in the GUI
set guioptions-=L
set guioptions-=r

" GRB: Put useful info in status line
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

" GRB: clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" GRB: set the color scheme
:set t_Co=256 " 256 colors
:let g:solarized_termcolors=16
:set background=dark
:color solarized

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

" Shortcuts for moving between windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")


" Powerline config
let g:Powerline_symbols = 'fancy'
