" --------------------------------------------
" ローカルの.vimrcに記載
" --------------------------------------------
" if filereadable(expand('~/home/.vimrc'))
"     source ~/home/.vimrc
" endif
" --------------------------------------------

" --------------------------------------------
" NeoBundle
" --------------------------------------------
set nocompatible              " be iMproved
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'deris/vim-duzzle'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-submode'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'stephpy/vim-php-cs-fixer'

" -------------------------------------------
" 外部ファイルの読み込み
" -------------------------------------------
if filereadable(expand('~/home/.vimrc.NERDTree'))
    source ~/home/.vimrc.NERDTree
endif

" -------------------------------------------
" 一般設定
" ------------------------------------------
filetype plugin indent on     " required!
filetype indent on
syntax on

set nu " 行番号
colo wombat " 色設定

" 空白文字とかの設定
set list

" tabの設定
set autoindent
set listchars=tab:>-
set noexpandtab
set shiftwidth=4
set softtabstop=4

" ビジュアルモード選択でclipboardコピー出来るように
set clipboard=unnamed,autoselect

" 行を強調表示
set cursorline


" if php-cs-fixer is in $PATH, you don't need to define line below
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
" let g:php_cs_fixer_level = "all"                  " which level ?
let g:php_cs_fixer_level = "PSR2"                  " which level ?
let g:php_cs_fixer_config = "default"             " configuration
let g:php_cs_fixer_php_path = "/usr/local/bin/php"               " Path to PHP
" If you want to define specific fixers:
"let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
