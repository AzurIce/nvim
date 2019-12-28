let mapleader=" "

syntax on

set number
set norelativenumber
set cursorline
set wrap
set showcmd
set wildmenu

exec "nohlsearch"
set ignorecase
set smartcase

noremap - Nzz
noremap = nzz
noremap <LEADER>q :nohlsearch<CR>

map s <nop>

noremap J 5j
noremap K 5k

map S :w<CR>
map Q :q<CR>

map R :source ~/.config/nvim/init.vim<CR>

color snazzy
let g:SnazzyTransparent = 1

call plug#begin('~/.nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'

call plug#end()
