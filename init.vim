if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ==================== System ====================
let &t_ut=''
set autochdir

let mapleader=" "

syntax on
" ==================== Editor Behavior ====================
set number
set relativenumber
set cursorline

set encoding=utf-8
set noexpandtab   " One <tab> will Be Saved     as      '\t' but not ' '
set tabstop=4     " One '\t'  will be displayed as four ' '
set shiftwidth=4  " One <tab> is equal to four <Space>
set softtabstop=4 " When you press the <Backspace>, four' ' will be deleted as a tab
set autoindent

set list
set listchars=tab:\|\ ,trail:▫

set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap

set tw=0
set indentexpr=
" fold the code
set foldmethod=indent
set foldlevel=99
set foldenable

set formatoptions-=tc
set noshowmode
set showcmd
set wildmenu
set shortmess+=c
set inccommand=split " 即时预览命令的效果,在preview中显示

set ttyfast    " Should make scrolling faster
set lazyredraw " Should make scrolling faster
" set visualbell " When an error occurs, blink the screen instead of ringing

silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

set colorcolumn=80
set updatetime=1000

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ==================== Terminal Behaviors ====================
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'

" ====================Some Settings====================
" set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
" setmouse=a

" ====================Search====================
exec "nohlsearch"
set ignorecase
set smartcase
noremap <A--> Nzz
noremap <A-=> nzz
noremap <A-q> :nohlsearch<CR>
" ====================xx====================
map s <nop>

noremap J 5j
noremap K 5k

map S :w<CR>
map Q :q<CR>
" map R :source ~/.config/nvim/init.vim<CR>
map R :source $MYVIMRC<CR>

" color snazzy
let g:SnazzyTransparent = 1

" ====================Split====================
map sh :set nosplitright<CR> :vsplit<CR>
map sj :set splitbelow<CR> :split<CR>
map sk :set nosplitbelow<CR> :split<CR>
map sl :set splitright<CR> :vsplit<CR>

map <A-h> :vertical res -5<CR>
map <A-j> :res -5<CR>
map <A-k> :res +5<CR>
map <A-l> :vertical res +5<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" ====================Tab====================
map N :tabe<CR>
map _ :-tabnext<CR>
map + :+tabnext<CR>


" ====================Sao Operations====================
noremap <LEADER>= 20A=<Esc>A + <Esc>20A=<Esc>0f+cl
noremap <LEADER>p APlug '+'<Esc>0f+cl
" Single line moving
noremap <C-S-j> ddp
noremap <C-S-k> ddkkp
" Markdown
autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap ,c `` <++><Esc>F`i
autocmd Filetype markdown inoremap ,C ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4ka
autocmd Filetype markdown inoremap ,h ==== <++><Esc>F=hi


" ==================== Compile Function ====================
map <F12> :call CompileAndRun()<CR>
func! CompileAndRun()
	exec "w"
	" save the file
	if &filetype == 'markdown'
		exec "MarkdownPreview"
	endif
endfunc


" ====================Plugs====================
call plug#begin('~/.nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

call plug#end()

" ==================== Plugin Settings ====================


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'chromium'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'



