" Show routes
" Copied from @garybernhardt
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

