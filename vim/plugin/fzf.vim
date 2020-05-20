" https://github.com/junegunn/fzf.vim
map <leader>gm :Files app/models<cr>
map <leader>gv :Files app/views<cr>
map <leader>gc :Files app/controllers<cr>
map <leader>gh :Files app/helpers<cr>
map <leader>gs :Files app/serializers<cr>
map <leader>gp :Files app/presenters<cr>
map <leader>gS :Files app/services<cr>
map <leader>gC :Files app/assets/stylesheets<cr>
map <leader>gJ :Files app/assets/javascripts<cr>

map <leader>gM :topleft 100 :sview db/schema.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
" map <leader>gt :CtrlPClearCache<cr>\|:CtrlPTag<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gR :call ShowRoutes()<cr>
map <leader>b :Buffers<cr>
map <leader>f :Files<cr>
map <leader>F :Files %%<cr>
map <leader>l :Lines<cr>

let g:ctrlp_map = '<leader>f'
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](\.gem|node_modules|vendor|build)$',
      \ }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
