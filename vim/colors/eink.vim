" vim:sw=8:ts=8
"
" act like t_Co=0 but use (256) color on just a few things
"
" NOTE Copied and modified from https://bitbucket.org/kisom/eink.vim
" CTERM colors: https://jonasjacek.github.io/colors/
" - Added String style because it's useful
" - Added NonText style for listmode characters

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "eink"

if &background == "light"
  hi Normal       cterm=NONE          ctermbg=white   ctermfg=235
  hi SpecialKey   cterm=NONE                          ctermfg=250
  hi NonText      cterm=NONE                          ctermfg=250
  hi IncSearch    cterm=NONE          ctermbg=183     ctermfg=NONE
  hi Search       cterm=NONE          ctermbg=183     ctermfg=NONE
  hi MoreMsg      cterm=bold                          ctermfg=NONE
  hi ModeMsg      cterm=bold                          ctermfg=NONE
  hi LineNr       cterm=NONE                          ctermfg=235
  hi StatusLine   cterm=bold,reverse                  ctermfg=NONE
  hi StatusLineNC cterm=reverse                       ctermfg=NONE
  hi VertSplit    cterm=reverse                       ctermfg=NONE
  hi Title        cterm=bold                          ctermfg=NONE
  hi Visual       cterm=reverse                       ctermfg=NONE
  hi VisualNOS    cterm=bold                          ctermfg=NONE
  hi WarningMsg   cterm=standout                      ctermfg=NONE
  hi WildMenu     cterm=standout                      ctermfg=NONE
  hi Folded       cterm=standout                      ctermfg=NONE
  hi FoldColumn   cterm=standout                      ctermfg=NONE
  hi DiffAdd      cterm=bold                          ctermfg=NONE
  hi DiffChange   cterm=bold                          ctermfg=NONE
  hi DiffDelete   cterm=bold                          ctermfg=NONE
  hi DiffText     cterm=reverse                       ctermfg=NONE
  hi Type         cterm=bold          ctermbg=NONE    ctermfg=NONE
  hi Keyword      cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Number       cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Char         cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Format       cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Special      cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Constant     cterm=None          ctermbg=NONE    ctermfg=NONE
  " hi PreProc      cterm=italic        ctermbg=254     ctermfg=NONE
  hi PreProc      cterm=None                          ctermfg=NONE
  hi Directive    cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Conditional  cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Comment      cterm=italic        ctermbg=254     ctermfg=NONE
  hi Func         cterm=None          ctermbg=234     ctermfg=250
  hi Identifier   cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Statement    cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Ignore       cterm=bold                          ctermfg=NONE
  hi String       cterm=bold          ctermbg=NONE    ctermfg=239
  hi ErrorMsg     cterm=reverse       ctermbg=15      ctermfg=9
  hi Error        cterm=reverse       ctermbg=15      ctermfg=9
  hi Todo         cterm=bold          ctermbg=253     ctermfg=NONE
  hi MatchParen   cterm=bold          ctermbg=NONE    ctermfg=12
  hi ColorColumn  cterm=NONE          ctermbg=255
  hi SignColumn   cterm=NONE          ctermbg=254
  hi CursorLine   cterm=NONE          ctermbg=255     ctermfg=NONE
  hi CursorLineNr cterm=bold          ctermbg=255     ctermfg=NONE
  hi Underlined   cterm=underline     ctermbg=254     ctermfg=NONE

  " FZF syntax attrs

  " Ale syntax attrs
  hi ALEError        cterm=NONE          ctermbg=254     ctermfg=205
  hi ALEErrorSign    cterm=bold          ctermbg=254     ctermfg=205
  hi ALEInfo         cterm=NONE          ctermbg=224     ctermfg=NONE
  hi ALEStyleError   cterm=NONE          ctermbg=254     ctermfg=NONE
  hi ALEStyleWarning cterm=NONE          ctermbg=254     ctermfg=NONE
  hi ALEWarning      cterm=NONE          ctermbg=254     ctermfg=NONE
  hi ALEWarningSign  cterm=bold          ctermbg=254     ctermfg=NONE

  " Syntastic attrs
  hi SyntasticErrorSign        cterm=bold ctermbg=254 ctermfg=208
  hi SyntasticWarningSign      cterm=bold ctermbg=254 ctermfg=208
  hi SyntasticStyleErrorSign   cterm=bold ctermbg=254 ctermfg=NONE
  hi SyntasticStyleWarningSign cterm=bold ctermbg=254 ctermfg=NONE

  hi UnwantedTrailerTrash      cterm=NONE ctermbg=218 ctermfg=NONE

  " Language-specific syntax attrs
  hi mkdInlineURL         cterm=underline     ctermbg=254     ctermfg=NONE
  hi rubyStringDelimiter  cterm=NONE
  hi link shOption Normal
  hi link Quote Normal
  hi link htmlItalic Normal

  " Ruby-specific syntax attrs
  hi link rubyStringDelimiter String
  hi link rubyStringEscape String
  hi link rubyInterpolation String
  hi link rubyInterpolationDelimiter String
else
  hi Normal       cterm=NONE          ctermbg=234     ctermfg=250
  hi SpecialKey   cterm=NONE                          ctermfg=255
  hi NonText      cterm=NONE                          ctermfg=255
  hi IncSearch    cterm=reverse                       ctermfg=NONE
  hi Search       cterm=reverse                       ctermfg=NONE
  hi MoreMsg      cterm=bold                          ctermfg=NONE
  hi ModeMsg      cterm=bold                          ctermfg=NONE
  hi LineNr       cterm=NONE                          ctermfg=238
  hi StatusLine   cterm=bold,reverse                  ctermfg=NONE
  hi StatusLineNC cterm=reverse                       ctermfg=NONE
  hi VertSplit    cterm=reverse                       ctermfg=NONE
  hi Title        cterm=bold                          ctermfg=NONE
  hi Visual       cterm=reverse                       ctermfg=NONE
  hi VisualNOS    cterm=bold                          ctermfg=NONE
  hi WarningMsg   cterm=standout                      ctermfg=NONE
  hi WildMenu     cterm=standout                      ctermfg=NONE
  hi Folded       cterm=standout                      ctermfg=NONE
  hi FoldColumn   cterm=standout                      ctermfg=NONE
  hi DiffAdd      cterm=bold                          ctermfg=NONE
  hi DiffChange   cterm=bold                          ctermfg=NONE
  hi DiffDelete   cterm=bold                          ctermfg=NONE
  hi DiffText     cterm=reverse                       ctermfg=NONE
  hi Type         cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Keyword      cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Number       cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Char         cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Format       cterm=None          ctermbg=NONE    ctermfg=NONE
  hi Special      cterm=underline     ctermbg=NONE    ctermfg=NONE
  hi Constant     cterm=None          ctermbg=NONE    ctermfg=NONE
  hi PreProc      cterm=None                          ctermfg=NONE
  hi Directive    cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Conditional  cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Comment      cterm=NONE          ctermbg=NONE    ctermfg=245
  hi Func         cterm=None          ctermbg=234     ctermfg=250
  hi Identifier   cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Statement    cterm=NONE          ctermbg=NONE    ctermfg=NONE
  hi Ignore       cterm=bold                          ctermfg=NONE
  hi String       cterm=underline                     ctermfg=NONE
  hi ErrorMsg     cterm=reverse       ctermbg=15      ctermfg=9
  hi Error        cterm=reverse       ctermbg=15      ctermfg=9
  hi Todo         cterm=bold,standout ctermbg=0       ctermfg=11
  hi MatchParen   cterm=bold          ctermbg=250     ctermfg=NONE
  hi ColorColumn                      ctermbg=255
  hi ColorColumn  cterm=NONE          ctermbg=235
  hi CursorLine   cterm=NONE          ctermbg=235     ctermfg=NONE
  hi CursorLineNr cterm=bold          ctermbg=235     ctermfg=NONE
endif
