########################################
# 環境変数
########################################
export LANG=ja_JP.UTF-8

# nodebrew
if [ -d $HOME/.nodebrew ]; then 
    export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# haskell
if [ -d $HOME/Library/Haskell/bin ]; then 
    export PATH=$HOME/Library/Haskell/bin:$PATH
fi

# Golang
if which go > /dev/null; then
    if [ ! -d $HOME/.go ]; then
        mkdir $HOME/.go
    fi
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOPATH/bin
fi


# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# rbenv
export RBENV_ROOT=$HOME/.rbenv
export PATH=$RBENV_ROOT/bin:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# phpbrew
if which phpbrew > /dev/null; then
    source $HOME/.phpbrew/bashrc
    export PHPBREW_SET_PROMPT=1
fi

# direnv
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

# MySQL
export MYSQL_PS1='\u@\h[\d] > '

# color setting
export TERM=xterm-256color

# Java options ( used by mvn ) 
export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"

# Homebrew
if which brew > /dev/null; then
    # brew cask option
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    # brew で入るパッケージを優先
    export PATH=$(brew --prefix)/bin:$PATH
fi

########################################
# antigen
########################################
if [ -f $(brew --prefix)/share/antigen.zsh ]; then
    source $(brew --prefix)/share/antigen.zsh
fi
if [ -f $HOME/.dotfiles/.zshrc.antigen ]; then
    source $HOME/.dotfiles/.zshrc.antigen
fi

########################################
# google cloud sdk
########################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then
    source $HOME/google-cloud-sdk/path.zsh.inc
fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then
    source $HOME/google-cloud-sdk/completion.zsh.inc
fi


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

# git のエスケープを有効
autoload -Uz git-escape-magic
git-escape-magic


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

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

########################################
# peco
########################################

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

# vim をpeco で開く
function peco-dir-open-app () {
    find . | grep -v .git | peco | xargs sh -c 'vim "$0" < /dev/tty'
    zle clear-screen
}
zle -N peco-dir-open-app
bindkey '^v^r' peco-dir-open-app     # C-v C-r

# git checkout をpeco 経由で実行
function peco-git-checkout () {
    git branch | peco | xargs git checkout
    zle accept-line
}
zle -N peco-git-checkout
bindkey '^g^r' peco-git-checkout    # C-g C-r

########################################
# tmux の起動
########################################
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

