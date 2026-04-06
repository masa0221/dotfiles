##########################
# asdf
##########################
[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ] && . /opt/homebrew/opt/asdf/libexec/asdf.sh

##########################
# bun
##########################
export BUN_INSTALL="$HOME/.bun"
[ -d "$BUN_INSTALL" ] && export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

##########################
# krew (kubectl plugin manager)
##########################
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

##########################
# PHP
##########################
[ -d /opt/homebrew/opt/php@8.0/bin ] && export PATH="/opt/homebrew/opt/php@8.0/bin:$PATH"
[ -d "$HOME/.composer/vendor/bin" ] && export PATH="$PATH:$HOME/.composer/vendor/bin"

##########################
# MySQL client
##########################
[ -d /opt/homebrew/opt/mysql-client@8.0/bin ] && export PATH="/opt/homebrew/opt/mysql-client@8.0/bin:$PATH"
