##########################
# OrbStack（要マシン調整）
##########################
[ -f ~/.orbstack/shell/init.zsh ] && source ~/.orbstack/shell/init.zsh 2>/dev/null

##########################
# Antigravity CLI（要マシン調整）
##########################
[ -d "$HOME/.antigravity/antigravity/bin" ] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

##########################
# JVM オプション（要プロジェクト調整）
##########################
export SBT_OPTS="-Xmx4G -Xms512M"
export BLOOP_JAVA_OPTS="-Xms512m -Xmx4g -XX:+UseZGC"

##########################
# プロジェクト固有 PATH（要マシン調整）
##########################
[ -d "$HOME/Sources/wonder-soft/matsuolab/tools" ] && export PATH="$HOME/Sources/wonder-soft/matsuolab/tools:$PATH"

##########################
# mcp-compose CLI
##########################
fpath=($HOME/.local/share/zsh/site-functions $fpath)
