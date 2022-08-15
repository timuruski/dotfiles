" https://github.com/junegunn/fzf.vim
" From zshrc:
" FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git --exclude .keep'
" FZF_DEFAULT_OPTS="--ansi --no-color"

command! -bang -nargs=? -complete=dir Files
      \call fzf#vim#files(<q-args>, {'options': ['--no-color']}, <bang>0)

map <leader>b :Buffers<cr>
map <leader>f :Files<cr>
map <leader>F :Files %%<cr>
map <leader>l :Lines<cr>

map <leader>gm :Files app/models<cr>
map <leader>gv :Files app/views<cr>
map <leader>gc :Files app/controllers<cr>
map <leader>gh :Files app/helpers<cr>
map <leader>gs :Files app/serializers<cr>
map <leader>gp :Files app/presenters<cr>
map <leader>gS :Files app/services<cr>
map <leader>gC :Files app/assets/stylesheets<cr>
map <leader>gJ :Files app/assets/javascripts<cr>

" Implement Rrg
" Implement Route finder for Sinatra app
" Implement conflict list

" Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }
function! s:find_route(refresh = 0)
  if a:refresh
    exec 'bin/routes > tmp/routes.txt'
  endif

  call fzf#vim#grep('cat tmp/routes.txt', 1)
endfunction

command! FindRoute call s:find_route()
nnoremap <leader>r :FindRoute<cr>
" nnoremap <leader>r :call s:find_route()<cr>
"
command! Conflicts call fzf#run(fzf#wrap({'source': 'git status --short | awk "/(AA|UU)/ { print \$2 }"'}))
