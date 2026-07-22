##########################
# OrbStack（要マシン調整）
##########################
[ -f ~/.orbstack/shell/init.zsh ] && source ~/.orbstack/shell/init.zsh 2>/dev/null

##########################
# Antigravity（要マシン調整）
##########################
[ -d "$HOME/.antigravity/antigravity/bin" ] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
[ -d "$HOME/.antigravity-ide/antigravity-ide/bin" ] && export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"

##########################
# JVM オプション（要プロジェクト調整）
##########################
export SBT_OPTS="-Xmx2G -Xms512M"
export BLOOP_JAVA_OPTS="-Xms512m -Xmx1g -XX:+UseZGC"

##########################
# mcp-compose CLI
##########################
fpath=($HOME/.local/share/zsh/site-functions $fpath)
