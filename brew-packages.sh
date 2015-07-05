# Update homebrew
brew update

# Upgrade already-installed packages
brew upgrade

# Add repositories
brew tap caskroom/cask
brew tap caskroom/homebrew-versions
brew tap peco/peco
brew tap homebrew/dupes
brew tap homebrew/versions

# Install brew-cask
brew install brew-cask

# Install brew-packages
brew install ansible
brew install autojump
brew install git-flow
brew install gnu-sed
brew install node
brew install peco
brew install the_silver_searcher
brew install tig
brew install tree
brew install vim
brew install wget
brew install homebrew/php/composer
brew install nodebrew
brew install tmux
brew install awscli
brew install reattach-to-user-namespace
brew install ctags

# Install ruby packages
brew install rbenv
brew install ruby-build
brew install rbenv-gemset
brew install rbenv-gem-rehash
brew install rbenv-default-gems
brew install readline
brew install apple-gcc42

# Install cask-packages
# brew cask option 
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
brew cask install virtualbox
brew cask install vagrant
brew cask install iterm2
brew cask install google-chrome
brew cask install google-drive
brew cask install skype
brew cask install firefox-ja
brew cask install bettertouchtool
brew cask install skitch
brew cask install filezilla
brew cask install intellij-idea-ce


# Remove outdated version
brew cleanup
