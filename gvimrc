if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>

  " Command-Shift-F for Ack
  map <D-F> :Ag<space>
endif

" Don't beep
set visualbell

" Start without the toolbar
set guioptions-=T

" Don't show scroll bars in the GUI
set guioptions-=L
set guioptions-=r

set guifont="Menlo Regular"
colorscheme base16-default
