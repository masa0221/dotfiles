##########################
# Homebrew
##########################
eval "$(/opt/homebrew/bin/brew shellenv)"
fpath+=$(brew --prefix)/share/zsh/site-functions

##########################
# 基本 PATH
##########################
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=~/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
