nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Search for nearest package.json
" This is because the directory for tmdb-mobile is weird.
function! NearestPackageJsonRoot() abort
  let l:dir = expand('%:p:h')
  while l:dir !=# '/' && !filereadable(l:dir . '/package.json')
    let l:dir = fnamemodify(l:dir, ':h')
  endwhile
  return l:dir !=# '/' ? l:dir : getcwd()
endfunction

let test#project_root = function("NearestPackageJsonRoot")

" Support for Racket tests
" let test#racket#rackunit#executable = 'raco test'
" let test#racket#rackunit#file_pattern = '\v^(test.*|.*-test).rkt$'
