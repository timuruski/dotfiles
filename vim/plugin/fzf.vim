" https://github.com/junegunn/fzf.vim
" From zshrc:
" FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git --exclude .keep'
" FZF_DEFAULT_OPTS="--ansi --no-color"

" Default :Files command colorizes everything, disable it.
command! -bang -nargs=? -complete=dir Files
      \call fzf#vim#files(<q-args>, {'options': ['--no-color']}, <bang>0)

map <leader>b :Buffers<cr>
map <leader>f :Files<cr>
map <leader>F :FilesWithoutTests<cr>
map <leader>g :Files %%<cr>
map <leader>m :Files db/migrate/<cr>
map <leader>r :Routes<cr>
map <leader>R :Routes!<cr>

" Fuzzy find just implementation files.
" ffd is an alias, which fzf#run doesn't handle.
function! s:files_without_tests()
  let ffd_cmd = 'fd --type file --ignore-file ~/.ignore --ignore-file ~/.ignore-tests'
  call fzf#run(fzf#vim#with_preview(fzf#wrap({'source': ffd_cmd, 'sink': 'e'})))
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
