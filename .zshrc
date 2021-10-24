##########################
# zinit
##########################
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# テーマのインストール
# (テーマに依存しているoh-my-zshのライブラリを追加し、テーマを追加する)
zinit for \
  OMZL::git.zsh \
  OMZL::theme-and-appearance.zsh \
  atload'RPROMPT=""' \
    OMZT::pmcgee

# 遅延読み込みすると動かないプラグイン
zinit for \
  tarruda/zsh-autosuggestions

# 遅延読み込みしても大丈夫なプラグイン
zinit wait lucid for \
  zsh-users/zsh-completions \
  zsh-users/zsh-syntax-highlighting \
  zdharma/history-search-multi-word \
  OMZP::autojump \
  b4b4r07/enhancd


##########################
# 自動補完関係
##########################

# 改行用の変数を用意
NEWLINE=$'\n'

# 補完候補の上にカテゴリを表示する
zstyle ':completion:*' format "${NEWLINE}%B%F{blue}[ Completing %d ]%f%b"
zstyle ':completion:*' group-name '' # 空文字にしておくとタグ名が自動的に設定される

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完対象の色が出る(ディレクトリやファイルが色でわかるようになる)
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 補完を選ぶときに色がつく（背景色） trueでメニュー補完を始める。selectで指定した候補以上になると選択(背景色が変わる)
zstyle ':completion:*:default' menu true select=2

# _complete 自動補完
# _approximate 近似値補完(候補が出る
# _prefix 単語の途中の補完
# _correct 完全な補完(候補無しで変換される
zstyle ':completion:*' completer _complete _approximate # _prefix

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# Shift-Tab で自動補完のカーソルを戻す
bindkey "^[[Z" reverse-menu-complete

# 補完機能の関数(compinit)を利用できるようにする
autoload -U compinit
# ユーティリティ関数が定義されて必要なすべてのシェル関数が自動ロードされるように調整される
compinit


##########################
# option設定
##########################
# アラート音をOFF
setopt NO_BEEP

# 同じコマンドをヒストリに残さない(ヒストリを^Pで呼び出す場合に困るのでonにしない)
# バッファの効率は良くなるので好み
# setopt HIST_IGNORE_ALL_DUPS
# 直前と同じコマンドはヒストリに保存しない
setopt HIST_IGNORE_DUPS

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt HIST_SAVE_NO_DUPS

# ヒストリに保存するときに余分なスペースを削除する
setopt HIST_REDUCE_BLANKS

# 同時に起動したzshの間でヒストリを共有する
setopt SHARE_HISTORY

# 関数定義のためのコマンドはヒストリに保存しない
setopt HIST_NO_FUNCTIONS

# インタラクティブシェルでコメントが書ける
setopt INTERACTIVE_COMMENTS


##########################
# エイリアス
##########################
alias ls='ls -G'
alias ll='ls -l'
alias l='ls -la'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

alias grep='grep --color=auto'

# 作業ディレクトリ作成&移動
alias wkdir='mkdir ~/work/$(date "+%Y-%m-%d") && cd ~/work/$(date "+%Y-%m-%d")'


##########################
# 環境変数
##########################
# 履歴保存ファイルの場所(インタラクティブシェル終了時に保存)
HISTFILE=${HOME}/.zsh_history

# 内部履歴リスト(メモリ内)に保存されるイベントの最大数
HISTSIZE=10000

# 履歴ファイルに保存する履歴イベントの最大数
SAVEHIST=50000

# 256色で表現
export TERM=xterm-256color

# fzfの設定: 高さ40%, 下に表示, fzfの表示は枠線を表示
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# MySQL
export MYSQL_PS1='\u@\h[\d] > '



##########################
# ファイル読み込み
##########################

() {
  local files=(
    # google cloud sdk
    $HOME/google-cloud-sdk/path.zsh.inc
    $HOME/google-cloud-sdk/completion.zsh.inc
  )
  local file
  for file in ${files[@]}; do
    [ -f ${file} ] && source ${file}
  done
}

