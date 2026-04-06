# Agent 用 .zshrc（ZDOTDIR 経由で使う場合）
# Cursor / Antigravity 以外のツールが ZDOTDIR を指定して起動するケースに対応
#
# このファイルは zinit / p10k / tmux 自動起動を含まない軽量版

##########################
# 環境（PATH 等）
##########################
# env.d モジュールが .zprofile 経由で読まれていない場合のフォールバック
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  for _envfile in ${HOME}/.zsh/env.d/*.zsh(N); do
    source "$_envfile"
  done
  unset _envfile
  [[ -f ${HOME}/.zsh/secrets.zsh ]] && source ${HOME}/.zsh/secrets.zsh
fi

##########################
# 履歴
##########################
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS SHARE_HISTORY

##########################
# シェルオプション
##########################
setopt NO_BEEP INTERACTIVE_COMMENTS AUTO_CD

##########################
# プロンプト（最小）
##########################
TERM=xterm-256color
PS1='%F{cyan}%~%f $ '

##########################
# エイリアス
##########################
alias ls='ls --color=always'
alias ll='ls -l'
alias l='ls -la'
alias grep='grep --color=always'

##########################
# 補完（キャッシュのみ）
##########################
autoload -U compinit && compinit -C
