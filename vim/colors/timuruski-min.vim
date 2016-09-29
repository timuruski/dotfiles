" Minimal colorscheme, only changes the color of comments and a few
" interface elements like diff and spell check.
"
" This is an experiment to see if syntax highlighting is missed.
" http://www.linusakesson.net/programming/syntaxhighlighting/

" Base16 Tomorrow (https://github.com/chriskempson/base16)
" Scheme: Chris Kempson (http://chriskempson.com)

" GUI color definitions
let s:gui00 = "1d1f21"
let s:gui01 = "282a2e"
let s:gui02 = "373b41"
let s:gui03 = "969896"
let s:gui04 = "b4b7b4"
let s:gui05 = "c5c8c6"
let s:gui06 = "e0e0e0"
let s:gui07 = "ffffff"
let s:gui08 = "cc6666"
let s:gui09 = "de935f"
let s:gui0A = "f0c674"
let s:gui0B = "b5bd68"
let s:gui0C = "8abeb7"
let s:gui0D = "81a2be"
let s:gui0E = "b294bb"
let s:gui0F = "a3685a"

" Terminal color definitions
let s:cterm00 = "00"
let s:cterm03 = "08"
let s:cterm05 = "07"
let s:cterm07 = "15"
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"
if exists('base16colorspace') && base16colorspace == "256"
  let s:cterm01 = "18"
  let s:cterm02 = "19"
  let s:cterm04 = "20"
  let s:cterm06 = "21"
  let s:cterm09 = "16"
  let s:cterm0F = "17"
else
  let s:cterm01 = "10"
  let s:cterm02 = "11"
  let s:cterm04 = "12"
  let s:cterm06 = "13"
  let s:cterm09 = "09"
  let s:cterm0F = "14"
endif

" Simplified colors
let s:gui_white   = "ffffff"
let s:gui_black   = "000000"
let s:gui_grey    = "303030"
let s:gui_red     = "ac4142"
let s:gui_green   = "90a959"
let s:cterm_white = "15"
let s:cterm_black = "00"
let s:cterm_grey  = "20"
let s:cterm_red   = "01"
let s:cterm_green = "01"

" Theme setup
hi clear
syntax reset
" let g:colors_name = "base16-default"
let g:colors_name = "timuruski-min"
set background=light

" Highlighting function
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  " if a:guifg != ""
  "   exec "hi " . a:group . " guifg=#" . s:gui(a:guifg)
  " endif
  " if a:guibg != ""
  "   exec "hi " . a:group . " guibg=#" . s:gui(a:guibg)
  " endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

" Return GUI color for light/dark variants
fun s:gui(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:gui00
    return s:gui07
  elseif a:color == s:gui01
    return s:gui06
  elseif a:color == s:gui02
    return s:gui05
  elseif a:color == s:gui03
    return s:gui04
  elseif a:color == s:gui04
    return s:gui03
  elseif a:color == s:gui05
    return s:gui02
  elseif a:color == s:gui06
    return s:gui01
  elseif a:color == s:gui07
    return s:gui00
  endif

  return a:color
endfun

" Return terminal color for light/dark variants
fun s:cterm(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:cterm00
    return s:cterm07
  elseif a:color == s:cterm01
    return s:cterm06
  elseif a:color == s:cterm02
    return s:cterm05
  elseif a:color == s:cterm03
    return s:cterm04
  elseif a:color == s:cterm04
    return s:cterm03
  elseif a:color == s:cterm05
    return s:cterm02
  elseif a:color == s:cterm06
    return s:cterm01
  elseif a:color == s:cterm07
    return s:cterm00
  endif

  return a:color
endfun

" Vim editor colors
call <sid>hi("Bold",          "", "", "", "", "bold")
call <sid>hi("Debug",         s:gui00, "", s:cterm00, "", "")
call <sid>hi("Directory",     s:gui00, "", s:cterm00, "", "")
call <sid>hi("ErrorMsg",      s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("Exception",     s:gui00, "", s:cterm00, "", "")
call <sid>hi("FoldColumn",    "", s:gui00, "", s:cterm00, "")
call <sid>hi("Folded",        s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("IncSearch",     s:gui00, "", s:cterm00, "", "")
call <sid>hi("Italic",        "", "", "", "", "none")
call <sid>hi("Macro",         s:gui00, "", s:cterm00, "", "")
call <sid>hi("MatchParen",    s:gui00, s:gui00, s:cterm00, s:cterm00,  "reverse")
call <sid>hi("ModeMsg",       s:gui00, "", s:cterm00, "", "")
call <sid>hi("MoreMsg",       s:gui00, "", s:cterm00, "", "")
call <sid>hi("Question",      s:gui00, "", s:cterm00, "", "")
call <sid>hi("Search",        s:gui00, s:gui00, s:cterm00, s:cterm00,  "reverse")
call <sid>hi("SpecialKey",    s:gui00, "", s:cterm00, "", "")
call <sid>hi("TooLong",       s:gui00, "", s:cterm00, "", "")
call <sid>hi("Underlined",    s:gui00, "", s:cterm00, "", "")
call <sid>hi("Visual",        "", s:gui00, "", s:cterm00, "")
call <sid>hi("VisualNOS",     s:gui00, "", s:cterm00, "", "")
call <sid>hi("WarningMsg",    s:gui00, "", s:cterm00, "", "")
call <sid>hi("WildMenu",      s:gui00, "", s:cterm00, "", "")
call <sid>hi("Title",         s:gui00, "", s:cterm00, "", "none")
call <sid>hi("Conceal",       s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("Cursor",        s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("NonText",       s:gui00, "", s:cterm00, "", "")
call <sid>hi("Normal",        s:gui00, s:gui00, s:cterm00, s:cterm00, "")
" call <sid>hi("LineNr",        s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("SignColumn",    s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("SpecialKey",    s:gui00, "", s:cterm00, "", "")
call <sid>hi("StatusLine",    s:gui00, s:gui00, s:cterm00, s:cterm00, "none")
call <sid>hi("StatusLineNC",  s:gui00, s:gui00, s:cterm00, s:cterm00, "none")
call <sid>hi("VertSplit",     s:gui00, s:gui00, s:cterm00, s:cterm00, "none")
call <sid>hi("ColorColumn",   "", s:gui00, "", s:cterm00, "none")
" call <sid>hi("CursorColumn",  "", s:gui00, "", s:cterm00, "none")
call <sid>hi("CursorLine",    s:gui00, s:gui00, "", s:cterm00, "none")
" call <sid>hi("CursorLine",    "", s:gui00, "", s:cterm00, "none")
" call <sid>hi("CursorLineNr",  s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("PMenu",         s:gui00, s:gui00, s:cterm00, s:cterm00, "none")
call <sid>hi("PMenuSel",      s:gui00, s:gui00, s:cterm00, s:cterm00, "reverse")
call <sid>hi("TabLine",       s:gui00, s:gui00, s:cterm00, s:cterm00, "none")
call <sid>hi("TabLineFill",   s:gui00, s:gui00, s:cterm00, s:cterm00, "none")
call <sid>hi("TabLineSel",    s:gui00, s:gui00, s:cterm00, s:cterm00, "none")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui00, "", s:cterm00, "", "")
call <sid>hi("Character",    s:gui00, "", s:cterm00, "", "")
call <sid>hi("Comment",      s:gui04, "", s:cterm04, "", "")
call <sid>hi("Conditional",  s:gui00, "", s:cterm00, "", "")
call <sid>hi("Constant",     s:gui00, "", s:cterm00, "", "")
call <sid>hi("Define",       s:gui00, "", s:cterm00, "", "none")
call <sid>hi("Delimiter",    s:gui00, "", s:cterm00, "", "")
call <sid>hi("Float",        s:gui00, "", s:cterm00, "", "")
call <sid>hi("Function",     s:gui00, "", s:cterm00, "", "")
call <sid>hi("Identifier",   s:gui00, "", s:cterm00, "", "none")
call <sid>hi("Include",      s:gui00, "", s:cterm00, "", "")
call <sid>hi("Keyword",      s:gui00, "", s:cterm00, "", "")
call <sid>hi("Label",        s:gui00, "", s:cterm00, "", "")
call <sid>hi("Number",       s:gui00, "", s:cterm00, "", "")
call <sid>hi("Operator",     s:gui00, "", s:cterm00, "", "none")
call <sid>hi("PreProc",      s:gui00, "", s:cterm00, "", "")
call <sid>hi("Repeat",       s:gui00, "", s:cterm00, "", "")
call <sid>hi("Special",      s:gui00, "", s:cterm00, "", "")
call <sid>hi("SpecialChar",  s:gui00, "", s:cterm00, "", "")
call <sid>hi("Statement",    s:gui00, "", s:cterm00, "", "")
call <sid>hi("StorageClass", s:gui00, "", s:cterm00, "", "")
call <sid>hi("String",       s:gui00, "", s:cterm00, "", "")
call <sid>hi("Structure",    s:gui00, "", s:cterm00, "", "")
call <sid>hi("Tag",          s:gui00, "", s:cterm00, "", "")
call <sid>hi("Todo",         s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("Type",         s:gui00, "", s:cterm00, "", "none")
call <sid>hi("Typedef",      s:gui00, "", s:cterm00, "", "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellLocal",   "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellCap",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellRare",    "", s:gui00, "", s:cterm00, "undercurl")

" Additional diff highlighting
call <sid>hi("DiffAdd",      s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("DiffChange",   s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("DiffDelete",   s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("DiffText",     s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("DiffAdded",    s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("DiffFile",     s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("DiffNewFile",  s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("DiffLine",     s:gui00, s:gui00, s:cterm00, s:cterm00, "")
call <sid>hi("DiffRemoved",  s:gui00, s:gui00, s:cterm00, s:cterm00, "")

" Remove functions
delf <sid>hi
delf <sid>gui
delf <sid>cterm

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F

" Underline search terms to lower craziness levels.
" if version >= 700 " Vim 7.x specific colors
"   hi Search         guifg=NONE        guibg=NONE        gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
"   hi Cursorline         guifg=NONE        guibg=NONE        gui=NONE ctermfg=NONE        ctermbg=NONE        cterm=NONE
" endif

