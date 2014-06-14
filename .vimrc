set nocompatible
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
Plugin 'othree/html5.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'moll/vim-node'
Plugin 'godlygeek/tabular'
Plugin 'spf13/PIV'
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
set laststatus=2
set nobackup
set nowb
set noswapfile
set showcmd
set linespace=8
set backspace=2
set scrolloff=7
set scrolljump=5
set foldmethod=indent
set foldlevelstart=1
set pastetoggle=<F2>
set list listchars=tab:\ \ ,trail:·

" Indentation.
set autoindent
set cindent
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
au FileType make,go,snippets,sh setlocal noexpandtab

" Syntax colors & color scheme
let g:solarized_termtrans = 1
if $ITERM_ENV == 'dark'
  set background=dark
elseif $ITERM_ENV == 'light'
  set background=light
else
  set background=dark
endif
colorscheme solarized

" Dictionaries.
au FileType javascript set dictionary+=$HOME/.vim/dict/vim-node-dict/dict/node.dict
au FileType php set dictionary+=$HOME/.vim/dict/vim-php-dictionary/dict/PHP.dict

" Highlight JSON as JavaScript.
autocmd BufNewFile,BufRead *.json set ft=javascript

" Source vimrc on save.
autocmd! bufwritepost .vimrc source %

" Better leader
let mapleader = ","

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Fast saving
nmap <leader>w :w!<cr>

" Easy out.
imap <leader><leader> <esc>

" Tabbing shortcuts
nmap th :tabnext<CR>
nmap tl :tabprev<CR>
nmap tn :tabnew<CR>
nmap td :tabclose<CR>
nmap <C-Right> :tabnext<cr>
nmap <C-Left> :tabprev<cr>

" Autocomplete html tags on </
iabbrev </ </<C-X><C-O>

" Folding.
nmap <space> za
nmap <leader><space> zR

" Copy & paste to clipboard
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

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

" Linter
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_php_checkers = ['php']
let syntastic_mode_map = { 'passive_filetypes': ['html'] } " make is so html files are only checked if you explicitly run :SyntasticCheck
