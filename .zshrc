##########################
# tmux の起動
##########################
if [ ! -z "$PS1" ]; then
  if [ -z "$TMUX" ]; then
    tmux_session=$(tmux ls -F '#S')
    if [ $? -ne 0 ]; then
      tmux
    else
      if [ ${#tmux_session} != 1 ]; then
        tmux ls
        read "tmux_session?Choose the session: "
      fi
      tmux attach -t ${tmux_session}
    fi
  fi
fi


##########################
# ファイル読み込み
##########################
function load_files_if_exists() {
  local file
  for file in ${@}; do
    [ -r ${file} ] && source ${file}
  done
}
# Powerlevel10k
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
load_files_if_exists $HOME/.cache/p10k-instant-prompt-${(%):-%n}.zsh


##########################
# zinit
##########################
### Added by Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
ZINIT_SRC=${ZINIT_HOME}/zinit.zsh
if [[ ! -f ${ZINIT_SRC} ]]; then
  sh -c "$(curl -fsSL https://git.io/zinit-install)"
fi

source "${ZINIT_SRC}"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# 遅延読み込みすると動かないプラグイン
zinit for \
  tarruda/zsh-autosuggestions

# 遅延読み込みしても大丈夫なプラグイン
zinit wait lucid for \
  zsh-users/zsh-completions \
  zdharma/history-search-multi-word \
  soimort/translate-shell \
  b4b4r07/enhancd \
  zdharma-continuum/fast-syntax-highlighting

zinit ice depth=1; zinit light romkatv/powerlevel10k


##########################
# 色設定
##########################
# $bg などの色をかんたんに扱えるようにする(OMZT::pmcgeeで利用中)
autoload -U colors && colors

# RPROMPTで$fg[$NCOLOR]などの変数を展開する(OMZT::pmcgeeで利用中)
setopt PROMPT_SUBST

# テーマのインストール
# (テーマに依存しているoh-my-zshのライブラリを追加し、テーマを追加する)
zinit for \
  OMZL::git.zsh \
  atload'RPROMPT=""' \
    OMZT::pmcgee


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

# menu: 補完を選ぶときに色がつく（背景色） menu true にすると1度タブを押すだけで補完される
# select: 指定した候補以上になると選択(背景色が変わる)
zstyle ':completion:*:default' menu select=2

# _complete 自動補完
# _approximate 近似値補完(候補が出る
# _prefix 単語の途中の補完
# _correct 完全な補完(候補無しで変換される
zstyle ':completion:*' completer _complete _approximate _prefix

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# Shift-Tab で自動補完のカーソルを戻す
bindkey "^[[Z" reverse-menu-complete

# 補完機能の関数(compinit)を利用できるようにする
autoload -U compinit
# ユーティリティ関数が定義されて必要なすべてのシェル関数が自動ロードされるように調整される
compinit


##########################
# シェル変数
##########################
# 履歴保存ファイルの場所(インタラクティブシェル終了時に保存)
HISTFILE=${HOME}/.zsh_history

# 内部履歴リスト(メモリ内)に保存されるイベントの最大数
HISTSIZE=10000

# 履歴ファイルに保存する履歴イベントの最大数
SAVEHIST=50000

# 256色で表現
TERM=xterm-256color

# fzfの設定: 高さ40%, 下に表示, fzfの表示は枠線を表示
FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# MySQL
MYSQL_PS1='\u@\h[\d] > '


##########################
# その他option設定
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

# cd なしでカレントディレクトリを移動
setopt AUTO_CD

# completer の _prefix を使うときは必要なOption
setopt COMPLETE_IN_WORD


##########################
# エイリアス
##########################
alias ls='ls --color=always'
alias ll='ls -l'
alias l='ls -la'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

alias grep='grep --color=always'

# 作業ディレクトリ作成&移動
alias wkdir='mkdir ~/work/$(date "+%Y-%m-%d") && cd ~/work/$(date "+%Y-%m-%d")'


##########################
# ファイル読み込み
##########################
files=(
  # google cloud sdk
  $HOME/google-cloud-sdk/path.zsh.inc
  $HOME/google-cloud-sdk/completion.zsh.inc
  # Powerlevel10k
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  $HOME/.p10k.zsh
)
load_files_if_exists ${files[*]}

