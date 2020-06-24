" Auto-install plug if it isn't already.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale', { 'do': 'npm i -g eslint tslint typescript prettier prettier-eslint' }
Plug 'StanAngeloff/php.vim'
Plug 'plasticboy/vim-markdown'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'vim-scripts/fountain.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'rust-lang/rust.vim'
Plug 'elzr/vim-json'
Plug 'hashivim/vim-terraform'
Plug 'vim-python/python-syntax'
Plug 'moll/vim-node'
Plug 'digitaltoad/vim-pug'
Plug 'wavded/vim-stylus'
Plug 'heavenshell/vim-jsdoc'
Plug 'jparise/vim-graphql'
Plug 'uarun/vim-protobuf'
Plug 'othree/html5.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'Quramy/tsuquyomi'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
" Plug 'tpope/vim-fugitive' " Currently causing go linting to fail.
Plug 'evidens/vim-twig'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'msanders/snipmate.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'sukima/xmledit'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'
call plug#end()

" Basic.
filetype indent plugin on
syntax on
set encoding=utf8
set number
set backspace=indent,eol,start
set termguicolors
set history=1000
set showcmd
set gcr=a:blinkon0
set visualbell
set t_vb=
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
set autoindent
set cindent
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
au FileType make,go,snippets,sh setlocal noexpandtab

" Make sexy.
let iterm_profile = $ITERM_PROFILE

" Setup dracula. Had to add the top two settings because:
" https://github.com/dracula/vim/issues/65
" let g:dracula_italic=0
" let g:dracula_colorterm=0
colorscheme nord

" Source vimrc on save.
autocmd! bufwritepost .vimrc source %

" Better leader
let mapleader = ","

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Easy out.
imap jk <esc>

" ,w saving
nmap <leader>w :w!<CR>

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

" Fix weird character in nerdtree.
" https://www.reddit.com/r/vim/comments/a4yzyt/g_characters_prefixing_directory_and_file_names/
let g:NERDTreeNodeDelimiter = "\u00a0"

" Sparkup
autocmd FileType html let g:sparkupNextMapping = '<c-t>'

" ALE Configuration.
" Linter
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
\   'go': ['gopls', 'gofmt'],
\   'javascript': ['eslint'],
\   'typescript': ['tsserver'],
\   'typescript.tsx': ['tsserver'],
\}
let g:ale_fixers = {
\  'css': ['prettier'],
\  'typescript': ['prettier'],
\  'typescript.tsx': ['prettier'],
\}
let g:ale_echo_msg_format = '%linter% (ale) says %s'

" Map ALE Reference functions to c-] and c-^.
function! ALELSPMappings()
	let l:lsp_found=0
	for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found=1 | endif | endfor
	if (l:lsp_found)
		nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
		nnoremap <buffer> <C-^> :ALEFindReferences<CR>
	else
		silent! unmap <buffer> <C-]>
		silent! unmap <buffer> <C-^>
	endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()

" Nerd Tree.
let g:NERDTreeDirArrowExpandable = '―'
let g:NERDTreeDirArrowCollapsible = '+'

" cd to current working directory.
autocmd BufEnter * silent! lcd %:p:h

" jsdoc
let g:jsdoc_allow_input_prompt = 1

" Lightline settings
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'absolutepath', 'modified' ] ]
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

let g:fugitive_gitlab_domains = ['https://github.com']

" php.vim
au FileType php let php_html_in_strings = 1
au FileType php let php_sql_query = 1

" Go
au FileType go let g:go_fmt_command = "goimports"
au FileType go nmap <C-]> gd
au FileType go nmap <C-[> :GoDefPop 1<CR>
au FileType go let g:go_rename_command = 'gopls'
au FileType go let g:go_auto_type_info = 1
au FileType go let g:go_fmt_fail_silently = 1
au FileType go let g:go_highlight_types = 1
au FileType go let g:go_highlight_fields = 1
au FileType go let g:go_highlight_functions = 1
au FileType go let g:go_highlight_function_calls = 1
au FileType go let g:go_highlight_operators = 1
au FileType go let g:go_highlight_extra_types = 1

" Rust
let g:rustfmt_autosave = 1

" TypeScript Mappings: https://github.com/Quramy/tsuquyomi
autocmd FileType typescript nmap <C-]> :TsuquyomiDefinition<CR>
autocmd FileType typescript nmap <C-[> :TsuquyomiGoBack<CR>
autocmd FileType typescript imap <C-o> <C-x><C-o>
autocmd FileType typescript let g:tsuquyomi_disable_quickfix = 1

" Highlight JSON as JavaScript.
autocmd BufNewFile,BufRead *.json set ft=javascript

" highlight the word under cursor in all places.
setl updatetime=300
highlight WordUnderCursor cterm=underline gui=underline
autocmd CursorHold * call HighlightCursorWord()
function! HighlightCursorWord()
    " if hlsearch is active, don't overwrite it!
    let search = getreg('/')
    let cword = expand('<cword>')
    if match(cword, search) == -1
        exe printf('match WordUnderCursor /\V\<%s\>/', escape(cword, '/\'))
    endif
endfunction
