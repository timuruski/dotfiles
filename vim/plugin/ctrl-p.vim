" Ctrl-P
map <leader>gm :CtrlPClearCache<cr>\|:CtrlP app/models<cr>
map <leader>gv :CtrlPClearCache<cr>\|:CtrlP app/views<cr>
map <leader>gc :CtrlPClearCache<cr>\|:CtrlP app/controllers<cr>
map <leader>gh :CtrlPClearCache<cr>\|:CtrlP app/helpers<cr>
map <leader>gs :CtrlPClearCache<cr>\|:CtrlP app/serializers<cr>
map <leader>gp :CtrlPClearCache<cr>\|:CtrlP app/presenters<cr>
map <leader>gS :CtrlPClearCache<cr>\|:CtrlP app/services<cr>
map <leader>gl :CtrlPClearCache<cr>\|:CtrlP lib<cr>
map <leader>gC :CtrlPClearCache<cr>\|:CtrlP app/assets/stylesheets<cr>
map <leader>gJ :CtrlPClearCache<cr>\|:CtrlP app/assets/javascripts<cr>

map <leader>gM :topleft 100 :sview db/schema.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CtrlPClearCache<cr>\|:CtrlPTag<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gR :call ShowRoutes()<cr>
map <leader>b :CtrlPClearCache<cr>\|:CtrlPBuffer<cr>
" map <leader>f :CtrlPClearCache<cr>\|:CtrlP<cr>
map <leader>F :CtrlPClearCache<cr>\|:CtrlP %%<cr>

let g:ctrlp_map = '<leader>f'
let g:ctrlp_custom_ignore = '\v[\/](\.gem|node_modules|vendor)[\/]'
