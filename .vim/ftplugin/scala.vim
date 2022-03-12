" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>

inoremap <silent> <expr> } CancelCloseBracket("}")
inoremap <silent> <expr> ] CancelCloseBracket("]")
inoremap <silent> <expr> ) CancelCloseBracket(")")

inoremap <silent> <expr> <CR> IndentNextLine()
inoremap <silent> <expr> <BS> RemoveCloseBracket()


" 開始の括弧を消したら閉じる括弧も消す
function! RemoveCloseBracket()
  let l:cursol_letter = getline(".")[col(".")-1]        " 今のカーソルにある文字
  let l:remove_target_letter = getline(".")[col(".")-2] " 削除対象の文字
  if s:isOpenBracketAndCloseBracket(remove_target_letter, cursol_letter)
    return "\<BS>\<Right>\<BS>"
  else
    return "\<BS>"
  endif
endfunction

" 終了のカッコが指定されているなら書かない
function! CancelCloseBracket(inputed_letter)
  let l:previous_inputed_letter = getline(".")[col(".")-2] " 入力した文字の一つ前

  " 対応するカッコか判定
  if s:isOpenBracketAndCloseBracket(previous_inputed_letter, a:inputed_letter)
    return "\<Right>"
  else
    return a:inputed_letter
  endif
endfunction

function! IndentNextLine()
  " matchを改行した場合インデントを入れる
  if getline(".") =~ " match$"
    return "\n\t"
  else
    " 隣接した{}で改行したらインデント
    return s:indentInnerBetweenBrackets()
  endif
endfunction

function! s:indentInnerBetweenBrackets()
  let l:cursol_letter = getline(".")[col(".")-1]  " 今のカーソルにある文字
  let l:inputed_letter = getline(".")[col(".")-2] " 入力した文字

  " カッコの間で改行するか判定
  if s:isOpenBracketAndCloseBracket(inputed_letter, cursol_letter)
    return "\n\t\n\<UP>\<END>"
  else
    return "\n"
  endif
endfunction

function! s:isOpenBracketAndCloseBracket(open_letter, close_letter)
  let l:targets="{},[],()"
  for l:brackets in split(l:targets, ",")
    if len(brackets) != 2
      continue
    endif
    if a:open_letter == brackets[0] && a:close_letter == brackets[1]
      return 1
    endif
  endfor
  return 0
endfunction

