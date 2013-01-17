" Extends
runtime colors/Tomorrow-night.vim

let g:colors_name = "timuruski-dark"

" Underline search terms to lower craziness levels.
if version >= 700 " Vim 7.x specific colors
  hi Search         guifg=NONE        guibg=NONE        gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
endif

