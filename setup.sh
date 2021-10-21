#!/bin/bash

# set -x

cd `dirname $0`

########################
## functions
########################
function put_dot_files() {
  local dotfiles=(.zshrc .gitconfig .gitignore .vimrc .tmux.conf .ideavimrc)
  for dotfile in ${dotfiles[@]}; do
    local destination=${HOME}/${dotfile}
    if [ -e ${destination} -a ! -L ${destination} ]; then
      read -p "File ${dotfile} is already exists. Please choose the action. [b: backup, o: overwrite, q: quit]: " DOTFILE_ACTION
      case "${DOTFILE_ACTION}" in
        [qQ]) exit 1 ;;
        [bB])
          local backupfile=${HOME}/${dotfile}.$(date "+%s")
          cp ${destination} ${HOME}/${dotfile}.$(date "+%s")
          echo "Backup file was created! (${backupfile})"
      esac
    fi
    ln -s -f $(pwd)/${dotfile} ${destination}
    echo "${dotfile} was created"
  done
}

function get_vim_plug_path() {
  echo "${HOME}/.vim/autoload/plug.vim"
}

function install_vim_plug() {
  local vimplug_inatall_path=$(get_vim_plug_path)
  if [ -f ${vimplug_inatall_path} ]; then
    echo "vim-plug is already installed."
  else
    read -p "Are you sure install vim-plug? [y/n]: " INSTALL_VIMPLUG
    case "${INSTALL_VIMPLUG}" in
      [nN]) exit 1 ;;
    esac
    curl -sfLo ${vimplug_inatall_path} --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "vim-plug was installed."
  fi
}

function install_vim_plugin() {
  if [ ! -f "$(get_vim_plug_path)" ]; then
    return 0
  fi

  read -p "Are you sure install VIM plugins by vim-plug? [y/n]: " INSTALL_VIMPLUG_PLUGIN
  case "${INSTALL_VIMPLUG_PLUGIN}" in
    [nN]) exit 1 ;;
    [yY]) 
      vim -c 'PlugStatus | PlugUpdate | PlugClean | PlugInstall | quit | quit'
      echo "VIM plugins was installed."
  esac
}

function display_message () {
  cat <<EOT

==========================
 ${1}
==========================
EOT
}

########################
## main
########################

display_message "dotfiles settings"
put_dot_files

display_message "VIM settings"
install_vim_plug
install_vim_plugin

