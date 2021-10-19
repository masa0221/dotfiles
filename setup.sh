#!/bin/bash

DOT_FILES=(.zshrc .gitconfig .gitignore .vimrc .tmux.conf .ideavimrc)
for DOT_FILE in ${DOT_FILES[@]}; do 
    ln -s -f ${HOME}/dotfiles/${DOT_FILE} ${HOME}/${DOT_FILE}
done

DEIN_DIR=${HOME}/.vim/dein
if [ ! -d ${DEIN_DIR} ]; then
    echo "Do you want to install Dein(vim plugin manager) ? (y/n):"
    read ANSWER

    if [ ${ANSWER} = "y" ]; then
        DEIN_PLUGIN_PATH=${DEIN_DIR}/repos/github.com/Shougo/dein.vim
        mkdir -p ${DEIN_PLUGIN_PATH}
        git clone https://github.com/Shougo/dein.vim ${DEIN_PLUGIN_PATH}
    fi
fi
