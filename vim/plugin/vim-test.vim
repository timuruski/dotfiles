nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>

" let test#javascript#mocha#options = '--require test/helper'
let test#javascript#mocha#options = '--compilers js:babel-core/register'
