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

" SQLUtilities
let g:sqlutil_align_comma = 1
vmap <silent>sf        <Plug>SQLU_Formatter<CR>
nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>

" -------------------------------------------
" neocomplcache
" -------------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

