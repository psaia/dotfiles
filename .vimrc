set nocompatible

" Set the runtime path to include Vundle and initialize.
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'ciaranm/detectindent'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/PHP-correct-Indenting'
Plugin 'msanders/snipmate.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
Plugin 'groenewege/vim-less'
Plugin 'tristen/vim-sparkup'
Plugin 'wavded/vim-stylus'
Plugin 'tpope/vim-surround'
Plugin 'sukima/xmledit'
Plugin 'bling/vim-airline'
call vundle#end()

" Basic.
filetype indent plugin on
syntax on
set encoding=utf8
set number
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set gcr=a:blinkon0
set visualbell
set autoread
set hidden
set wrap
set textwidth=0
set wrapmargin=0
set hlsearch
set incsearch
set smartcase
set autoindent
set smartindent
set autochdir
set laststatus=2
set nobackup
set nowb
set noswapfile
set showcmd
set linespace=8
set backspace=2
set scrolloff=7
set scrolljump=5
set title
set foldmethod=indent
set foldlevelstart=1
set foldnestmax=3
set pastetoggle=<F2>
set list listchars=tab:\ \ ,trail:·

" Better leader
let mapleader = ","

" Indentation via DetectIndent http://www.vim.org/scripts/script.php?script_id=1171
autocmd BufReadPost * :DetectIndent
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2

" Custom filetype tab exceptions...
au FileType snippets set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
au FileType make set tabstop=2 softtabstop=2 shiftwidth=4 noexpandtab
au FileType go set tabstop=2 softtabstop=2 shiftwidth=4 noexpandtab

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Fast saving
nmap <leader>w :w!<cr>

" Tabbing shortcuts
nmap th :tabnext<CR>
nmap tl :tabprev<CR>
nmap tn :tabnew<CR>
nmap td :tabclose<CR>
nmap <C-Right> :tabnext<cr>
nmap <C-Left> :tabprev<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Folding.
nmap <space> za
nmap <leader><space> zR

" Copy & paste to clipboard
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Easy out.
imap jj <esc>

" Easy motion
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" Sparkup
let g:sparkupNextMapping = '<c-t>'

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bower_components\|svn'

" Syntax colors & color scheme
let g:solarized_termtrans = 1

if $ITERM_ENV == 'dark'
  set background=dark
elseif $ITERM_ENV == 'light'
  set background=light
else
  " echo "$ITERM_ENV not set. Defaulting to dark background"
  set background=dark
endif
colorscheme solarized

" Linter
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_php_checkers = ['php']

" make is so html files are only checked if you explicitly run :SyntasticCheck
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Highlight JSON as JavaScript.
autocmd BufNewFile,BufRead *.json set ft=javascript

" Source vimrc on save.
autocmd! bufwritepost .vimrc source %

