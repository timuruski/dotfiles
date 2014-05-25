" Command-T
set wildignore=vendor/**,tmp/**

" Shortcuts
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gd :CommandTFlush<cr>\|:CommandT app/decorators<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT app/services<cr>
map <leader>gM :topleft 100 :sview db/schema.rb<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gS :CommandTFlush<cr>\|:CommandT app/assets/stylesheets<cr>
map <leader>gJ :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gR :call ShowRoutes()<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>
" Map <esc> to close Command-T window
let g:CommandTCancelMap=['<C-c>', '<esc>']


