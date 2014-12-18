########################################
# 環境変数
########################################
export LANG=ja_JP.UTF-8

# brew で入るパッケージを優先
export PATH=/usr/local/bin:$PATH

# brew cask option 
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# nodebrew
if [ -d $HOME/.nodebrew ]; then 
    export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# MySQL
export MYSQL_PS1='\u@\h[\d] > '

########################################
# oh my zsh
########################################
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pmcgee"

plugins=(brew git git-flow sublime vagrant autojump composer ruby rbenv gem npm node tmux aws)
source $ZSH/oh-my-zsh.sh

# 右の時間だけいらないから上書き
RPROMPT=''

########################################
# 単語設定/補完
########################################

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# オプション
########################################
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# = の後はパス名として補完する
setopt magic_equal_subst

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
setopt extended_glob


########################################
# エイリアス
########################################

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias vi='vim'
alias j='autojump'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

########################################
# peco
########################################

# vim をpeco で開く
function peco-dir-open-app () {
    find . | peco | xargs sh -c 'vim "$0" < /dev/tty'
    zle clear-screen
}
zle -N peco-dir-open-app
bindkey '^v^r' peco-dir-open-app     # C-v C-r

# historyをpecoでanyting search
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history # C-r
