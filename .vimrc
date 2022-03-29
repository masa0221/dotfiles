" --------------------------------------------------
" vim-plug の設定
" --------------------------------------------------
" vim-plugのwindowを水平分割で下に表示
let g:plug_window='belowright 10new'

call plug#begin('~/.vim/plugged')
  " Vim日本語マニュアル
  Plug 'https://github.com/vim-jp/vimdoc-ja.git'

  " 翻訳
  Plug 'voldikss/vim-translator'

  " カラースキーム
  Plug 'rafi/awesome-vim-colorschemes'

  " ステータスライン表示
  Plug 'itchyny/lightline.vim'

  " gitのブランチ表示をステータスラインで利用する用
  Plug 'itchyny/vim-gitbranch'

  " 行番号の左にgitの差分を表示
  Plug 'airblade/vim-gitgutter'

  " git操作系
  Plug 'tpope/vim-fugitive'

  " コメントアウトの操作
  Plug 'tpope/vim-commentary'

  " 括弧を自動入力
  Plug 'jiangmiao/auto-pairs'

  " Tagbar(構造)を表示
  Plug 'preservim/tagbar'

  " markdown のプレビュー
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

  " fzf本体のインストール
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  " fzfのvimプラグイン
  Plug 'junegunn/fzf.vim'

  " windowのサイズ変更を簡単にするプラグイン
  Plug 'simeji/winresizer'

  " オートコンプリートができる(LSPにも対応している)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" --------------------------------------------------
" 表示設定
" --------------------------------------------------
" 行番号の表示
set number

" 行番号の強調表示
set cursorline

" listモード(タブや行末などの表示をする設定)をON
set list

" listモードで表示する文字を設定
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
" 括弧の表示設定
" --------------------------------------------------
set showmatch
set matchtime=1
set matchpairs& matchpairs+=<:>


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
" インサートモード
" --------------------------------------------------
" start 挿入区間の始めでバックスペースを働かせる
" eol 改行を超えてバックスペースを働かせる (行を連結する)
" indent インデントを超えてバックスペースを働かせる
set backspace=start,eol,indent


" --------------------------------------------------
" ファイル検索
" --------------------------------------------------
"  ag コマンドが利用可能ならagで検索する
if executable('ag')
  " 参考: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
  set grepprg=ag\ --vimgrep

  function! Grep(...)
    " ag と同じ使い方ができるように引数をスペースで結合する
    " ag --vimgrep [引数] [引数]
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
  endfunction

  " -nargs=+               引数が必ず必要
  " -complete=file_in_path path内のファイルとディレクトリに対して
  " -bar                   パイプを指定できる
  " cgetexpr               quickfixリストの作成(lgetexprはlocationリスト)
  " Grep(<f-args>)         Grep関数を実行
  command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
  command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

  " コマンド入力時に自動的にgrepをGrepに変更
  cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
  cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

  augroup quickfix
    autocmd!
    " cgetexpr が実行された後に自動的にquickfixのリストを開く
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
  augroup END
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
" ファイル種類の関連付け
" --------------------------------------------------
autocmd BufRead,BufNewFile *.sbt,*.sc set filetype=scala


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
" fzfの設定
" --------------------------------------------------
" fzf でファイルを選択する時に利用するキーバインド
" CTRL-tはtmuxに当てているので、CTRL-mを当てている
" fzf_actionのデフォルトではctrl-xでsplitだがctrl-sの方が覚えやすいので変更
let g:fzf_action = {
  \ 'ctrl-m': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }


" --------------------------------------------------
" 未分類
" --------------------------------------------------
"  通知音をすべてOFFにする
set belloff=all

" 隠れバッファを有効にする(バッファ変更後バッファ移動で警告が出ないように)
set hidden

" ノーマルモードでのコマンドを右下に表示する
set showcmd

" exコマンドの履歴
set history=5000

" ディスクに書き込まれるまでの時間[ms](入力がない状態から数える)
" また、CursorHoldが呼び出されるまでの時間にも利用される
" vim-gitgutterの中でこの値が参照されていて、sign(+-などの表示)の更新に使われる
" https://github.com/airblade/vim-gitgutter/blob/256702dd1432894b3607d3de6cd660863b331818/plugin/gitgutter.vim#L234
set updatetime=100

" 仮想編集(文字がない場所も選択)できるように設定
" (block: 矩形ビジュアルモード)
set virtualedit=block


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
try 
  colorscheme sonokai
catch
  echo 'The specified theme could not be loaded. Note: It is occured always when initial installing.'
endtry


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
" Windowサイズを変更(simeji/winresizer)
" --------------------------------------------------
" 起動を CTRL-w の後に e を押す設定に変更
" (<C-e>がデフォルトなのでスクロールとぶつかるため)
let g:winresizer_start_key = '<C-w>e'


" --------------------------------------------------
" 括弧の入力設定(jiangmiao/auto-pairs)
" --------------------------------------------------
let g:AutoPairsFlyMode = 1


" --------------------------------------------------
" 翻訳(voldikss/vim-translator)
" --------------------------------------------------
" 翻訳後の言語
let g:translator_target_lang='ja'

" 利用するエンジン
let g:translator_default_engines=['google']

" popupの最大幅(Windowの高さに対する相対的な割合)
let g:translator_window_max_width=0.6

" popupの最大の高さ(Windowの幅に対する相対的な割合)
let g:translator_window_max_height=0.8

" 翻訳ウィンドウの種類
let g:translator_window_type='popup'


" --------------------------------------------------
" キーマッピング
" --------------------------------------------------
" <Leader> を スペースキーに変更
let mapleader="\<Space>"

" ノーマルモード: F2 で.vimrcを開く
nnoremap <F2> :e $MYVIMRC<CR>

" ノーマルモード: F5 で.vimrcを再読み込み
nnoremap <F5> :source $MYVIMRC<CR>

" ノーマルモード: SHIFT-F5 で現在未設定のプラグインファイルを削除 & プラグインインストール
nnoremap <S-F5> :PlugClean<BAR>PlugInstall<CR>

" ノーマルモード: CTRL-l
"  ファイル再読み込み(bufferを更新)
"  検索ハイライトを消す
nnoremap <C-l> :e<BAR>:noh<CR>

" ノーマルモード: F8 でTagbar(構造)を表示
nnoremap <F8> :TagbarToggle<CR>

" ノーマルモード: CTRL-p でMarkdownをプレビュー/停止(markdownファイルのみ有効)
nmap <C-p> <Plug>MarkdownPreviewToggle

" ノーマルモード: CTRL-s でMarkdownプレビューを停止(markdownファイルのみ有効)
nmap <C-s> <Plug>MarkdownPreviewStop

" ノーマルモード: ファイル名検索(git管理しているファイルのみ)をfzfで行う
nnoremap <Leader>ff :GFiles<CR>

" ノーマルモード: ファイル名検索をfzfで行う
nnoremap <Leader>f<S-f> :Files<CR>

" ノーマルモード: ファイル内容検索をfzfで行う
nnoremap <Leader>fa :Ag<CR>

" ノーマルモード: バッファ名検索をfzfで行う
nnoremap <Leader>fb :Buffers<CR>

" ノーマルモード: コマンド検索をfzfで行う
nnoremap <Leader>fc :Commands<CR>

" ノーマルモード: ヘルプタグ検索をfzfで行う
nnoremap <Leader>fh :Helptags<CR>

" ノーマルモード: カーソルがあるワードを翻訳(window表示)
nnoremap <Leader>tw :TranslateW <C-r><C-w><CR>

" ノーマルモード: カーソルがある行を翻訳(window表示)
nnoremap <Leader>tt :TranslateW <C-r><C-l><CR>

" ビジュアルモード: 選択範囲を翻訳(window表示)
vnoremap <Leader>tt :TranslateW<CR>


nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

