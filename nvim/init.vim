call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set expandtab
set shiftwidth=2
set softtabstop=2
set number
