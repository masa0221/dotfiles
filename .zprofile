##########################
# env.d モジュール読み込み（ログインシェル）
##########################
# dotfiles リポジトリ内の zsh/env.d/*.zsh を番号順に source
# setup.sh により ~/.zsh/env.d/ にシンボリックリンクされる
for _envfile in ${HOME}/.zsh/env.d/*.zsh(N); do
  source "$_envfile"
done
unset _envfile

##########################
# シークレット（リポジトリ外・各マシンで手動配置）
##########################
[[ -f ${HOME}/.zsh/secrets.zsh ]] && source ${HOME}/.zsh/secrets.zsh
