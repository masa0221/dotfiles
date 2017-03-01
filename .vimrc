" -------------------------------------------
" 外部ファイルの読み込み
" -------------------------------------------
if filereadable(expand('~/.dotfiles/.vimrc.dein'))
    source ~/.dotfiles/.vimrc.dein
endif
if filereadable(expand('~/.dotfiles/.vimrc.NERDTree'))
    source ~/.dotfiles/.vimrc.NERDTree
endif

if filereadable(expand('~/.dotfiles/.vimrc.unite'))
    source ~/.dotfiles/.vimrc.unite
endif

" -------------------------------------------
" 色設定
" ------------------------------------------
syntax on
set background=dark
colorscheme molokai
let g:rehash256 = 1
let g:molokai_original = 1
highlight Normal ctermbg=none
highlight LineNr ctermbg=none
" highlight SignColumn ctermbg=none
" highlight VertSplit ctermbg=none
" highlight NonText ctermbg=none
highlight Comment       ctermfg=50  " コメント
highlight Delimiter     ctermfg=262 " 括弧(キモいからあとで調整

" -------------------------------------------
" 一般設定
" ------------------------------------------
filetype plugin indent on     " required!

set nu " 行番号
set hlsearch

" statusline
set laststatus=2

let g:lightline = {
      \ 'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \     'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \     'readonly': '(&filetype!="help"&& &readonly)',
      \     'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }

" 空白文字とかの設定
set list
set backspace=2

" tabの設定
set autoindent
set listchars=eol:¶,tab:▸\ 
" set noexpandtab " タブ文字の挿入
set expandtab " ソフトタブ
set shiftwidth=4
set softtabstop=0
set tabstop=4

" ビジュアルモード選択でclipboardコピー出来るように
set clipboard=unnamed,autoselect

" 行を強調表示
set cursorline

" vim-tags
autocmd BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"

" vimにmdファイルタイプを認識させる
autocmd BufRead,BufNewFile *.md set filetype=markdown
" 開いた状態にする
" let g:vim_markdown_initial_foldlevel=3
set nofoldenable

" vimにcoffeeファイルタイプを認識させる
autocmd BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee

" インデントを設定
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
autocmd FileType html setlocal sw=2 sts=2 ts=2 et
autocmd FileType css setlocal sw=2 sts=2 ts=2 et
autocmd FileType twig setlocal sw=2 sts=2 ts=2 et

" PHP
if filereadable(expand('~/.vim/dictionaries/php.dict'))
    autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dictionaries/php.dict filetype=php
endif

" Go lang
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/
inoremap <silent> <CR> <CR><c-o>:pclose<CR>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" SQLUtilities
let g:sqlutil_align_comma = 1
vmap <silent>sf        <Plug>SQLU_Formatter<CR>
nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>

" -------------------------------------------
" neocomplete
" -------------------------------------------
highlight Pmenu ctermbg=17
highlight PmenuSel ctermbg=24
highlight PMenuSbar ctermbg=32
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" -------------------------------------------
" neosnippet
" -------------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/dein/vim-snippets/snippets'
