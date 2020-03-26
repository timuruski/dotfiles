if has("autocmd")
  " These patterns are for pollen
  au BufReadPost *.*.pm,*.*.pmd,*.*.pp set filetype=racket

  au BufReadPost *.rkt,*.rktl set filetype=racket
  au filetype racket set lisp
  au filetype racket set autoindent
endif
