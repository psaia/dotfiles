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

" Spaces most of the time.
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Tabs some of the time.
au FileType make,go,sh setlocal noexpandtab

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

" ALE Configuration.
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
\  'go': ['gopls'],
\  'javascript': ['eslint'],
\  'typescript': ['tsserver'],
\  'typescript.tsx': ['tsserver'],
\}
let g:ale_fixers = {
\  'css': ['prettier'],
\  'javascript': ['eslint'],
\  'typescript': ['prettier'],
\  'typescript.tsx': ['prettier'],
\}
let g:ale_echo_msg_format = '%linter% (ale) says %s'
let g:ale_javascript_prettier_use_local_config = 1

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
autocmd BufRead,FileType typescript call ALELSPMappings()

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

" Go (basically all fixing is disabled so Ale handles it)
let g:go_rename_command = 'gopls'
let g:go_imports_command = "goimports"
let g:go_fmt_command = "gopls"
let g:go_metalinter_enabeld = ['deadcode', 'errcheck', 'gosimple', 'govet', 'staticcheck', 'typecheck', 'unused', 'varcheck']
let g:go_metalinter_autosave = 0
let g:go_imports_autosave = 1
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 0
let g:go_auto_type_info = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 0
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_format_strings = 0

" Rust
let g:rustfmt_autosave = 1

" TypeScript Mappings: https://github.com/Quramy/tsuquyomi
autocmd FileType typescript nmap <C-]> :TsuquyomiDefinition<CR>
autocmd FileType typescript nmap <C-[> :TsuquyomiGoBack<CR>
autocmd FileType typescript imap <C-o> <C-x><C-o>
autocmd FileType typescript let g:tsuquyomi_disable_quickfix = 1

" Highlight JSON as JavaScript.
autocmd BufNewFile,BufRead *.json set ft=javascript

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
