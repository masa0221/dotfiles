##########################
# Homebrew
##########################
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ -n "${HOMEBREW_PREFIX:-}" ]] && [[ -d "${HOMEBREW_PREFIX}/share/zsh/site-functions" ]]; then
  fpath+=("${HOMEBREW_PREFIX}/share/zsh/site-functions")
fi

##########################
# 基本 PATH
##########################
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=~/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
