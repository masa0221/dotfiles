" --------------------------------------------------
" 表示設定
" --------------------------------------------------
" 行番号の表示
set number

" 行番号の強調表示
set cursorline

" タブや行末などの表示設定
set list
set listchars=tab:▸\ ,eol:↵,trail:.,extends:…,precedes:…

" 検索のハイライトを有効
set hlsearch


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
" vim-plug の設定
" --------------------------------------------------
" 下に表示
let g:plug_window = 'belowright 10new'

call plug#begin('~/.vim/plugged')
  " Vim日本語マニュアル
  Plug 'https://github.com/vim-jp/vimdoc-ja.git'

  " ステータスライン表示
  Plug 'itchyny/lightline.vim'

  " gitのブランチ表示をステータスラインで利用する用
  Plug 'itchyny/vim-gitbranch'

  " 行番号の左にgitの差分を表示
  Plug 'airblade/vim-gitgutter'

  " git操作系
  Plug 'tpope/vim-fugitive'

  " カラースキーム
  Plug 'sainnhe/sonokai'
call plug#end()


" --------------------------------------------------
" カラースキーム
" --------------------------------------------------
if has('termguicolors')
  set termguicolors
endif
" The configuration options should be placed before `colorscheme sonokai`
let g:sonokai_style = 'maia'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai


" --------------------------------------------------
" ステータスラインの設定
" --------------------------------------------------
" ステータスラインを常に表示
set laststatus=2

" lightlineの設定
let g:lightline = {
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

" 変更内容の色設定(左にgitの差分を表示)
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
highlight SignColumn ctermbg=none

