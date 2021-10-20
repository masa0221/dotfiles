#!/bin/bash

DOT_FILES=(.zshrc .gitconfig .gitignore .vimrc .tmux.conf .ideavimrc)
for DOT_FILE in ${DOT_FILES[@]}; do 
  ln -s -f ${HOME}/dotfiles/${DOT_FILE} ${HOME}/${DOT_FILE}
done

VIMPLUG_INATALL_PATH=${HOME}/.vim/autoload/plug.vim
if [ ! -f ${VIMPLUG_INATALL_PATH} ]; then
  read -p "Are you sure install vim-plug? [y/n]: " INSTALL_VIMPLUG
  case "${INSTALL_VIMPLUG}" in
  [nN]) exit 1 ;;
  esac
    curl -fLo ${VIMPLUG_INATALL_PATH} --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
