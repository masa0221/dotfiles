#!/bin/bash

DOT_FILES=(.zshrc .gitconfig .vimrc)

for file in ${DOT_FILES[@]}; do 
    if [ ! -f $HOME/$file ]; then 
        ln -s $HOME/dotfiles/$file $HOME/$file
    fi
done

if [ ! -d ~/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    vim -c ':NeoBundleInstall'
fi

echo 'Finished!'
