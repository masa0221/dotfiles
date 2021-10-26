" --------------------------------------------------
" vim-plug の設定
" --------------------------------------------------
" 下に表示
let g:plug_window='belowright 10new'

call plug#begin('~/.vim/plugged')
  " Vim日本語マニュアル
  Plug 'https://github.com/vim-jp/vimdoc-ja.git'

  " カラースキーム
  Plug 'sainnhe/sonokai'

  " ステータスライン表示
  Plug 'itchyny/lightline.vim'

  " gitのブランチ表示をステータスラインで利用する用
  Plug 'itchyny/vim-gitbranch'

  " 行番号の左にgitの差分を表示
  Plug 'airblade/vim-gitgutter'

  " git操作系
  Plug 'tpope/vim-fugitive'
call plug#end()


" --------------------------------------------------
" 表示設定
" --------------------------------------------------
" 行番号の表示
set number

" 行番号の強調表示
set cursorline

" タブや行末などの表示設定
set list
set listchars=tab:▸\ ,lead:.,eol:↵,trail:.,extends:…,precedes:…


" --------------------------------------------------
" インデント設定
" --------------------------------------------------
" <Tab>の文字で表示されるスペースの数
set tabstop=2

" ソフトタブにする
set expandtab

" ソフトタブの幅として使用されるスペースの数
set softtabstop=2

" インデントに使われるスペースの数
set shiftwidth=2


" --------------------------------------------------
" 検索
" --------------------------------------------------
" 検索のハイライトを有効
set hlsearch

" 検索前にハイライト
set incsearch

" 大文字小文字を区別しない
set ignorecase

" 大文字が含まれていたらignorecaseを上書き
set smartcase


" --------------------------------------------------
" ファイル検索
" --------------------------------------------------
"  ag コマンドが利用可能ならagで検索する
if executable('ag')
  set grepprg=ag\ $*\ --nogroup
  set grepformat=%f:%l:%m
endif


" --------------------------------------------------
" 補完
" --------------------------------------------------
" コマンドライン補完の拡張をON
set wildmenu

" 補完対象の除外リスト
set wildignore=*.swp


" --------------------------------------------------
" タブ
" --------------------------------------------------
"  タブを常に表示
set showtabline=2


" --------------------------------------------------
" Netrw(ファイラ)の設定
" --------------------------------------------------
" tree view 表示
let g:netrw_liststyle=3

" vでファイルを右に開ける
let g:netrw_altv=1

" ウィンドウの表示割合を変更(単位:%)
let g:netrw_winsize=80

" 非表示にするファイルを指定
let g:netrw_list_hide=netrw_gitignore#Hide().'.*\.swp$'


" --------------------------------------------------
" 未分類
" --------------------------------------------------
"  通知音をすべてOFFにする
set belloff=all

" バッファ変更後バッファ移動で警告が出ないように
set hidden

" ノーマルモードでのコマンドを右下に表示する
set showcmd

" exコマンドの履歴
set history=5000


" --------------------------------------------------
" カラースキーム
" --------------------------------------------------
if has('termguicolors')
  set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`
let g:sonokai_style='maia'
let g:sonokai_enable_italic=1
let g:sonokai_disable_italic_comment=1
colorscheme sonokai


" --------------------------------------------------
" ステータスラインの設定
" --------------------------------------------------
" ステータスラインを常に表示
set laststatus=2

" lightlineの設定
let g:lightline={
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }


" --------------------------------------------------
" Git関係
" --------------------------------------------------
" 差分表示を100msに変更(vim-gitgutter)
set updatetime=100

