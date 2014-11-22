#!/bin/bash

DOT_FILES=(.zshrc .gitconfig .gitignore .vimrc .tmux.conf)

for DOT_FILE in ${DOT_FILES[@]}; do 
    ln -s -f $HOME/.dotfiles/$DOT_FILE $HOME/$DOT_FILE
done

if [ ! -d ~/.vim/bundle ]; then
    \mkdir -p ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
    vim -c ':NeoBundleInstall'
fi

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Do you want to install oh-my-zsh ? (y/n):"
    read ANSWER

    if [ ${ANSWER} = "Y" or ${ANSWER} = "y" or ${ANSWER} = "yes" ]; then
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
fi
