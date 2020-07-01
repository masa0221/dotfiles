# Update homebrew
brew update

# Upgrade already-installed packages
brew upgrade

# Add repositories
brew tap peco/peco
brew tap homebrew/dupes

# Install brew-packages
brew install zsh
brew install zplug
brew install ansible
brew install autojump
brew install git-flow
brew install gnu-sed
brew install peco
brew install the_silver_searcher
brew install tig
brew install tree
brew install vim
brew install wget
brew install tmux
brew install awscli
brew install ctags
brew install mysql
brew install reattach-to-user-namespace
brew install anyenv
brew install fzf
brew install jq

# Remove outdated version
brew cleanup

# Install zplug plugins
zplug install
