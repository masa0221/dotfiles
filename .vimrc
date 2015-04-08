" --------------------------------------------
" NeoBundle
" --------------------------------------------
filetype off

if has('vim_starting')
    set nocompatible               " Be iMproved

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'kien/ctrlp.vim'

" haskell
NeoBundle 'ujihisa/neco-ghc'

" markdownのプラグインについて
" http://www.key-p.com/blog/staff/archives/9032
NeoBundle 'tpope/vim-markdown'
NeoBundle 'joker1007/vim-markdown-quote-syntax'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

NeoBundle 'terryma/vim-multiple-cursors'

NeoBundle 'derekwyatt/vim-scala'

" SQL
NeoBundle 'vim-scripts/SQLUtilities'
NeoBundle 'Align' " SQLUtilitiesで必要

" git
NeoBundle 'airblade/vim-gitgutter'

" color scheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'

" statusline
NeoBundle 'itchyny/lightline.vim'

call neobundle#end()

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
NeoBundleCheck

" -------------------------------------------
" 外部ファイルの読み込み
" -------------------------------------------
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
highlight Normal ctermbg=none
highlight LineNr ctermbg=none
" highlight SignColumn ctermbg=none
" highlight VertSplit ctermbg=none
" highlight NonText ctermbg=none

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
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_visible_condition': {
      \     'readonly': '(&filetype!="help"&& &readonly)',
      \     'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ }
      \ }

" 空白文字とかの設定
set list
set backspace=2

" tabの設定
set autoindent
set listchars=tab:>-
" set noexpandtab " タブ文字の挿入
set expandtab " ソフトタブ
set shiftwidth=4
set softtabstop=0
set tabstop=4

" ビジュアルモード選択でclipboardコピー出来るように
set clipboard=unnamed,autoselect

" 行を強調表示
set cursorline

" vimにmdファイルタイプを認識させる
autocmd BufRead,BufNewFile *.md set filetype=markdown
" 開いた状態にする
" let g:vim_markdown_initial_foldlevel=3
set nofoldenable

" vimにcoffeeファイルタイプを認識させる
autocmd BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee

" インデントを設定
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et

" SQLUtilities
let g:sqlutil_align_comma = 1
vmap <silent>sf        <Plug>SQLU_Formatter<CR>
nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>
