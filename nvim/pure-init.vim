set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" source ~/.vim/vimrc
"
" NOTE: This is a copy of my vimrc, I'm in the process of breaking it apart for neovim.

" Tim Uruski's amazing Vim configuration, mixes minimalism with
" ideas from Gary Bernhardt and Tim Pope.

" Vimplug
call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'csexton/trailertrash.vim'

" Plug 'chriskempson/base16-vim', {'do': 'git checkout dict_fix'}
" FIX for https://github.com/chriskempson/base16-vim/issues/197
Plug 'danielwe/base16-vim'

" Colorschemes
" Plug 'andreypopp/vim-colors-plain'
" Plug 'pbrisbin/vim-colors-off'
" Plug 'https://bitbucket.org/kisom/eink.vim.git'

Plug 'aliou/bats.vim'
Plug 'bakpakin/fennel.vim'
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'janko-m/vim-test'
Plug '/opt/homebrew/opt/fzf' | Plug 'junegunn/fzf.vim'
" Plug 'jeroenbourgois/vim-actionscript', { 'for': 'actioncript' }
Plug 'janet-lang/janet.vim'
Plug 'jpalardy/vim-slime'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
" Plug 'tpope/vim-rake', { 'for': 'ruby' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" Plug 'vim-scripts/ag.vim'
" Plug 'vim-scripts/nimrod.vim'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'vim-utils/vim-man'
" Plug 'vimwiki/vimwiki'
Plug 'wlangstroth/vim-racket'

" Syntax checkers
" Ale slows vim down a lot, use Syntastic instead.
" Plug 'w0rp/ale'
Plug 'scrooloose/syntastic'

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

" Big bucket of settings.
set hidden
set ignorecase
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set matchtime=2
set modelines=0
set relativenumber
set number
set showmatch
set smartcase
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
set textwidth=96

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
" nmap Q <Nop>

" Disable weird effect when Ctrl-Space is pressed in Insert mode.
imap <Nul> <Space>

" Shortcut to directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Shortcut to type the lozenge character for Pollen
" ◊	LZ	25CA	9674	LOZENGE
digraph lz 9674
digraph -b 0x2011

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

" Start new undo sequence at each line.
inoremap <CR> <C-]><C-G>u<CR>

" *noremap here doesn't work because % is an expression
" These interfere with <C-i> and jumps.
" nmap <tab> %
" vmap <tab> %

inoremap <C-l> <Nop>

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

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" vim-slime
let g:slime_target = "vimterminal"

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
command! -nargs=+ RunRuby nnoremap <buffer> <enter> :w \| !clear; ruby <args> <CR>
command! -nargs=0 RunRuby nnoremap <buffer> <enter> :w \| !clear; ruby % <CR>
" command! -nargs=0 RunRacket nnoremap <buffer> <enter> :w \| !clear; racket % <CR>
command! -nargs=* RunRacket nnoremap <buffer> <enter> :w \| !clear; racket % <args> <CR>
command! -nargs=0 RunMake nnoremap <buffer> <enter> :w \| make! <CR>
command! -nargs=* RunMake nnoremap <buffer> <enter> :w \| make! <args> <CR>
command! -nargs=0 RunTest nnoremap <enter> :w \| :TestFile <CR>
command! -nargs=0 RunGo nnoremap <buffer> <enter> :w \| !clear; go run % <CR>
command! -nargs=0 RunNone nunmap <buffer> <enter>

function! s:RunCmd()
  " Command name
  " Command args
  " Buffer reference?
  " - write
  " - clear terminal
  " - execute command
  " - maybe press <enter>
  " - Leading colon, vim command?
  echom "RunCmd"
endfunction

" Visual style
" Attempt to get 24-bit color and italics
" https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
" let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
" set termguicolors

set t_Co=256
set colorcolumn=96
" colorscheme plain
colorscheme eink

" Toggle background
nmap <F2> :let &background = ( &background == "dark"? "light" : "dark" )<CR>


" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif

" Examine path
command! Path :echo join(split(&path, ","), "\n")
