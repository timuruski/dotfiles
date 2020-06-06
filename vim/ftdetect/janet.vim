" Janet https://janet-lang.org
if has("autocmd")
  au BufRead,BufNewFile *.janet set filetype=janet
  " au BufReadPost *.janet set filetype=janet
  au filetype janet set lisp
  au filetype janet set autoindent
  au filetype janet set softtabstop=2
endif
