if &compatible
    set nocompatible
endif

let s:pluginpath = ""
if has('win32')
    let s:pluginpath = ""
else
    if empty(glob('~/.nvim/dein/repos/github.com/Shougo/dein.vim'))
        !git clone https://github.com/Shougo/dein.vim ~/.nvim/dein/repos/github.com/Shougo/dein.vim
    endif
    set runtimepath+=~/.nvim/dein/repos/github.com/Shougo/dein.vim
    let s:pluginpath = "~/.nvim/dein"
endif

call dein#begin(s:pluginpath)
    call dein#add("~/.nvim/dein/repos/github.com/Shougo/dein.vim")
"   call dein#add("ayu-theme/ayu-vim")
    call dein#add("drewtempelmeyer/palenight.vim")
    call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
                    \ 'build': 'sh -c "cd app && yarn install"' })
    call dein#add('preservim/nerdtree')
    call dein#add('Xuyuanp/nerdtree-git-plugin')
"   call dein#add('dense-analysis/ale')
    call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
    call dein#add('vim-airline/vim-airline')
    call dein#add('airblade/vim-gitgutter')
call dein#end()

if dein#check_install()
 call dein#install()
endif

filetype plugin indent on
syntax enable

" ======= palenight =======
" set background=dark
colorscheme palenight

" ======= ayu =======
set termguicolors
" let TIME_H = strftime("%H")
" if TIME_H >= 7 && TIME_H <= 17
"   let ayucolor = "light"
" else
"   let ayucolor = "dark"
" endif
" colorscheme ayu

map H <nop>
map L <nop>
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>
noremap J 7j
noremap K 7k
noremap H 0
noremap L <End>

set number
set relativenumber
set cursorline
set showcmd
set wildmenu

set encoding=utf-8
set expandtab
" set noexpandtab   " One <tab> will Be Saved     as      '\t' but not ' '
set tabstop=4     " One '\t'  will be displayed as four ' '
set shiftwidth=4  " One <tab> is equal to four <Space>
set softtabstop=4 " When you press the <Backspace>, four' ' will be deleted as a tab
set autoindent

let mapleader = " "

" ======= search =======
set ignorecase
set incsearch
set smartcase
noremap - Nzz
noremap = nzz
noremap <ESC> :nohlsearch<CR>:NERDTreeClose<CR>

" ======= Sao Operations =======

" Single line moving
noremap <C-J> ddp
noremap <C-K> ddkkp

" ======= Compile functions =======
map <LEADER>c :call Compile()<CR>
func! Compile()
    exec 'w'
    if &filetype == 'c'
        exec '!gcc % -o %<'
        exec '!time konsole -e ./%<'
        " exec '!time ./%<'
    elseif &filetype == 'cpp'
        exec '!g++ % -o %<'
        exec '!time konsole -e ./%<'
    elseif &filetype == 'markdown'
        exec 'MarkdownPreview'
    endif
endfunc


let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-cmake',
            \ 'coc-css',
            \ 'coc-cssmodules',
            \ 'coc-eslint',
            \ 'coc-gist',
            \ 'coc-git',
            \ 'coc-glslx',
            \ 'coc-go',
            \ 'coc-graphql',
            \ 'coc-highlight',
            \ 'coc-html',
            \ 'coc-htmldjango',
            \ 'coc-htmlhint',
            \ 'coc-html-css-support',
            \ 'coc-java',
            \ 'coc-json',
            \ 'coc-markdownlint',
            \ 'coc-powershell',
            \ 'coc-prettier',
            \ 'coc-python',
            \ 'coc-sh',
            \ 'coc-stylelintplus',
            \ 'coc-svg',
            \ 'coc-tailwindcss',
            \ 'coc-translator',
            \ 'coc-tsserver',
            \ 'coc-webview',
            \ 'coc-xml',
            \ 'coc-yaml']


" ======= Markdown =======
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'chromium'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']


" ======= nerdtree =======
map <LEADER>e :NERDTreeToggle<CR>
let NERDTreeMapChangeRoot = "l"
let NERDTreeMapUpdir = "h"
let NERDTreeMapUpdirKeepOpen = ""
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif



" ======= gitgutter =======
let g:gitgutter_map_keys = 0

