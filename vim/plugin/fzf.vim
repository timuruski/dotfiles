" https://github.com/junegunn/fzf.vim
" From zshrc:
" FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git --exclude .keep'
" FZF_DEFAULT_OPTS="--ansi --no-color"

" Default :Files command colorizes everything, disable it.
command! -bang -nargs=? -complete=dir Files
      \call fzf#vim#files(<q-args>, {'options': ['--no-color']}, <bang>0)

" Fuzzy find git merge files with conflicts.
" TODO Create a quick fix list for the actual conflict markers.
command! GitConflicts call fzf#run(fzf#wrap({'source': 'git status --short | awk "/(AA|UU)/ { print \$2 }"'}))

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>F :FilesWithoutTests<cr>
nnoremap <leader>g :Files %%<cr>
nnoremap <leader>r :Routes<cr>
nnoremap <leader>R :Routes!<cr>


" Fuzzy find just implementation files.
" Note fzf#vim#grep expects a line number, so this doesn't work properly.
function! s:files_without_tests()
  " fd --ignore-file ~/.ignore --ignore-file ~/.ignore-tests
  " let dot_ignore = expand('~/.ignore')
  " let dot_ignore_tests = expand('~/.ignore-tests')
  " call fzf#vim#grep('fd --ignore-file ' . dot_ignore . ' --ignore-file ' . dot_ignore_tests, 0, fzf#vim#with_preview())
  " call fzf#vim#grep('fd --ignore-file ~/.ignore --ignore-file ~/.ignore-tests', 0, fzf#vim#with_preview())
  call fzf#run({'source': 'fd --ignore-file ~/.ignore --ignore-file ~/.ignore-tests', 'sink': 'e'})
endfunction

command! FilesWithoutTests call s:files_without_tests()

" Routes finder for TMDB codebase.
function! s:routes(refresh = 0)
  if a:refresh
    silent exec "!bin/routes 2>/dev/null > tmp/routes.txt"
  endif

  " call fzf#vim#grep('cat tmp/routes.txt', 0)
  call fzf#vim#grep('cat tmp/routes.txt', 0, fzf#vim#with_preview())
endfunction

command! -bang Routes call s:routes(<bang>0)

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
