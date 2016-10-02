call plug#begin('~/.vim/plugged')
Plug 'L9'
Plug 'scrooloose/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'evidens/vim-twig'
Plug 'Lokaltog/vim-easymotion'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'msanders/snipmate.vim'
Plug 'tomtom/tcomment_vim'
Plug 'kchmck/vim-coffee-script'
Plug 'digitaltoad/vim-jade'
Plug 'groenewege/vim-less'
Plug 'tristen/vim-sparkup'
Plug 'wavded/vim-stylus'
Plug 'tpope/vim-surround'
Plug 'sukima/xmledit'
Plug 'itchyny/lightline.vim'
Plug 'moll/vim-node'
Plug 'othree/html5.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'StanAngeloff/php.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'pangloss/vim-javascript'
Plug 'heavenshell/vim-jsdoc'
Plug 'plasticboy/vim-markdown'
Plug 'sheerun/dracula-theme'
Plug 'chriskempson/base16-vim'
Plug 'vim-scripts/fountain.vim'
Plug 'joonty/vdebug.git'
Plug 'shumphrey/fugitive-gitlab.vim'
call plug#end()

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
set nowrap
set synmaxcol=400
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

" My colorscheme. When using iterm make sure you're using the
" appropriate color profile.
" https://github.com/chriskempson/base16-vim
" https://github.com/chriskempson/base16-iterm2

" set background=light
" colorscheme base16-default
color dracula

" Dictionaries. Listed in neocomplete plugin.
au FileType javascript set dictionary+=$HOME.'/.vim/dict/vim-node-dict/dict/node.dict'
au FileType javascript set dictionary+=$HOME.'/.vim/dict/vim-dict/dict/javascript.dic'
au FileType php set dictionary+=$HOME.'/.vim/dict/vim-php-dictionary/dict/PHP.dict'
au FileType css set dictionary+=$HOME.'/.vim/dict/vim-dict/dict/css.dic'

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
imap jk <esc>

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

" SnipMate Configuration
let g:snips_author = 'PS'

" Easy motion
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
nmap s <Plug>(easymotion-s2)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" NerdTree
let g:NERDTreeChDirMode=2

" Sparkup
let g:sparkupNextMapping = '<c-t>'

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|bower_components\|svn'
let g:ctrlp_regexp = 1


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Linter
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_loc_list_height = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php']
let syntastic_mode_map = { 'passive_filetypes': ['html'] } " make is so html files are only checked if you explicitly run :SyntasticCheck
let g:NERDTreeDirArrowExpandable = '―'
let g:NERDTreeDirArrowCollapsible = '+'

" php.vim
au FileType php let php_html_in_strings = 1
au FileType php let php_sql_query = 1

" cd to current working directory.
autocmd BufEnter * silent! lcd %:p:h

" jsdoc
let g:jsdoc_allow_input_prompt = 1

" Lightline settings
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

let g:fugitive_gitlab_domains = ['http://dev.lev-interactive.com']
