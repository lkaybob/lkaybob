call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" requires nvim-tree.lua file
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Plug 'lifepillar/vim-solarized8', { 'dir': '~/.config/nvim/colors/solarized8' }

" https://github.com/nvim-lualine/lualine.nvim
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

set expandtab
set shiftwidth=2
set softtabstop=2
set number

" Disable for OSX
" colo solarized8

luafile ~/.config/nvim/nvim-tree.lua
luafile ~/.config/nvim/lualine.lua

set expandtab
set shiftwidth=2
set softtabstop=2
set number

" nvim-tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
