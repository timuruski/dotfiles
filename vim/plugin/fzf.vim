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
map <leader>r :Routes<cr>
map <leader>R :Routes expand("%")<cr>
map <leader>E :FailedExamples<cr>

" Fuzzy find just implementation files.
" ffd is an alias, which fzf#run doesn't handle.
function! s:files_without_tests()
  let ffd_cmd = 'fd --type file --ignore-file ~/.ignore --ignore-file ~/.ignore-tests'
  call fzf#run(fzf#vim#with_preview(fzf#wrap({'source': ffd_cmd, 'sink': 'e'})))
endfunction

command! FilesWithoutTests call s:files_without_tests()

" Routes finder for TMDB codebase.
function! s:routes(prefix = "")
  if a:prefix == ""
    let l:cmd = "cat tmp/routes.txt"
  else
    let l:cmd = "grep " .. a:prefix .. " tmp/routes.txt"
  endif

  call fzf#vim#grep(l:cmd, 0, fzf#vim#with_preview())
endfunction

function! s:refresh_routes()
  silent exec "!bin/routes 2>/dev/null > tmp/routes.txt"
endfunction

command! -nargs=? Routes call s:routes(<args>)
command! RefreshRoutes call s:refresh_routes()

" Failed examples
function! s:failed_examples()
  let cmd = 'grep failed spec/examples.txt | sed -E "s/\[.*//" | sort -u'
  call fzf#run(fzf#vim#with_preview(fzf#wrap({'source': cmd, 'sink': 'e'})))
endfunction

" command! FailedExamples call s:failed_examples()

" Failed examples args list
function! s:failed_examples()
  let cmd = 'grep failed spec/examples.txt | sed -E "s/\[.*//" | sort -u'
  call fzf#run(fzf#vim#with_preview(fzf#wrap({'source': cmd, 'sink': 'e'})))
endfunction

command! FailedExamples call s:failed_examples()

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
