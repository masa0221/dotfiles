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

" -------------------------------------------
" 外部ファイルの読み込み
" -------------------------------------------
if filereadable(expand('~/.vimrc.NERDTree'))
    source ~/.vimrc.NERDTree
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
" set noexpandtab
" set shiftwidth=4
" set softtabstop=4

" ビジュアルモード選択でclipboardコピー出来るように
set clipboard=unnamed,autoselect
