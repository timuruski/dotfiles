" Extends
runtime colors/base16-tomorrow.vim

set background=light
let g:colors_name = "timuruski-light"

" Underline search terms to lower craziness levels.
if version >= 700 " Vim 7.x specific colors
  hi Search         guifg=NONE        guibg=NONE        gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
  hi Cursorline         guifg=NONE        guibg=NONE        gui=NONE ctermfg=NONE        ctermbg=NONE        cterm=NONE
endif

