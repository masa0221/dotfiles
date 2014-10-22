#!/bin/bash

DOT_FILES=(.zshrc .gitconfig .gitignore .vimrc .peco)

for file in ${DOT_FILES[@]}; do 
    ln -s -f $HOME/.dotfiles/$file $HOME/$file
done

if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    vim -c ':NeoBundleInstall'
fi

echo "Install oh-my-zsh ? (y/n):"
read answer

if [ "${answer} = "Y" or "${answer} = "y" ]; then
    if [ ! -d ~/.oh-my-zsh ]; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
fi

echo 'Finished!'
