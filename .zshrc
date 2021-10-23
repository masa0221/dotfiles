# アラート音をOFF
setopt NO_BEEP
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

# Shift-Tab で自動補完のカーソルを戻す
bindkey "^[[Z" reverse-menu-complete

# 補完機能の関数(compinit)を利用できるようにする
autoload -U compinit
# ユーティリティ関数が定義されて必要なすべてのシェル関数が自動ロードされるように調整される
compinit


# zplug (brew install zplug のあとに以下を指定)
export ZPLUG_HOME=/usr/local/opt/zplug
source ${ZPLUG_HOME}/init.zsh

# 補完機能の関数(zsh標準で入っていないものを利用できるように)
zplug "zsh-users/zsh-completions", lazy:true

# テーマファイルを読み込む
zplug "themes/pmcgee", from:oh-my-zsh, hook-load:"RPROMPT=''"

# コマンド入力時に色がつく
zplug "zsh-users/zsh-syntax-highlighting", defer:2

export TERM=xterm-256color # コレを設定しておかないと色が薄めにならない
zplug "tarruda/zsh-autosuggestions", defer:2

# brew install autojump のあとに以下を指定
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
zplug "plugins/autojump", from:oh-my-zsh, lazy:true

# cd コマンドを拡張してインタラクティブにできるもの
zplug "b4b4r07/enhancd", use:init.sh

# # 高機能なワイルドカード展開を使用する
# setopt extended_glob を使うときは以下を入れる(キャレットが特殊文字になるため)
# zplug "knu/zsh-git-escape-magic", lazy:true

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load


# インタラクティブシェル終了時に履歴保存ファイル
HISTFILE=${HOME}/.zsh_history
# メモリ内に保存される履歴の最大数
HISTSIZE=10000
SAVEHIST=50000

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


# 高さ40%, 下に表示, fzfの表示は枠線を表示
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# historyをpecoでanyting search
function fzf-select-history() {
    # history 逆順,番号ナシ,1行目から取得 | 逆順にする(入力が新しい順) | 入力された内容でフィルタ
    # BUFFER変数はコマンドの入力前の値
    BUFFER=$(history -rn 1 | fzf -q "${LBUFFER}")

    # カーソルをバッファの文字数に指定(つまり CURSOR=$ と対して変わらん)
    # CURSORが0なら最初になり、$なら最後になる
    # $#BUFFER はBUFFER変数内の文字数を出力
    CURSOR=${#BUFFER}

    # コマンドラインを再表示
    # zle clear-screen を使うと画面ごとリセットされるのでナシ
    zle redisplay
}
# ユーザー定義のwidgetsは-Nを指定することで定義できる
zle -N fzf-select-history
bindkey '^r' fzf-select-history # C-r

# alias
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

