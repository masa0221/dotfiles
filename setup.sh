#!/bin/bash

cd `dirname $0`

########################
## functions
########################
function put_dot_files() {
  local dotfiles=(.zshenv .zprofile .zshrc .zsh/functions.zsh .gitconfig .gitignore .vimrc .tmux.conf .ideavimrc .vim/ftplugin)
  for dotfile in ${dotfiles[@]}; do
    [ ! -e ${dotfile} ] && continue  # ファイルまたはディレクトリが存在しない場合、スキップ
    local destination=${HOME}/${dotfile}
    local destination_dir=$(dirname "${destination}")
    [ ! -d "${destination_dir}" ] && mkdir -p "${destination_dir}"

    if [ -e ${destination} -a ! -L ${destination} ]; then
      read -p "File ${dotfile} is already exists. Please choose the action. [b: backup, o: overwrite, q: quit]: " DOTFILE_ACTION
      case "${DOTFILE_ACTION}" in
        [qQ]) exit 1 ;;
        [bB])
          local backupfile=${HOME}/${dotfile}.$(date "+%s")
          cp -r ${destination} ${backupfile}
          echo "Backup file was created! (${backupfile})"
      esac
    fi
    if [ -e "${destination}" ]; then  # ファイルまたはディレクトリが存在する場合
      rm -r ${destination}
    fi
    ln -s -f $(pwd)/${dotfile} ${destination}
    echo "${dotfile} was created"
  done
}

function put_zsh_env_d() {
  local envd_src="$(pwd)/zsh/env.d"
  local envd_dest="${HOME}/.zsh/env.d"

  [ ! -d "${envd_src}" ] && return 0

  mkdir -p "${envd_dest}"

  for envfile in ${envd_src}/*.zsh; do
    local basename=$(basename "${envfile}")
    local dest="${envd_dest}/${basename}"
    if [ -e "${dest}" -a ! -L "${dest}" ]; then
      read -p "File .zsh/env.d/${basename} already exists. [b: backup, o: overwrite, q: quit]: " ENVD_ACTION
      case "${ENVD_ACTION}" in
        [qQ]) exit 1 ;;
        [bB])
          cp "${dest}" "${dest}.$(date "+%s")"
          echo "Backup created for ${basename}"
      esac
    fi
    ln -s -f "${envfile}" "${dest}"
    echo ".zsh/env.d/${basename} was created"
  done
}

function setup_secrets() {
  local secrets_dest="${HOME}/.zsh/secrets.zsh"
  if [ ! -f "${secrets_dest}" ]; then
    echo ""
    echo "💡 secrets.zsh が未設定です。以下のコマンドでテンプレートからコピーしてください："
    echo "   cp $(pwd)/zsh/secrets.zsh.example ${secrets_dest}"
    echo "   vim ${secrets_dest}"
    echo ""
  else
    echo "secrets.zsh is already configured."
  fi
}

function put_agent_zdotdir() {
  local src="$(pwd)/zsh/agent-zdotdir"
  local dest="${HOME}/.zsh/agent-zdotdir"

  [ ! -d "${src}" ] && return 0

  if [ -e "${dest}" -a ! -L "${dest}" ]; then
    read -p "Directory .zsh/agent-zdotdir already exists. [b: backup, o: overwrite, q: quit]: " AGENT_ACTION
    case "${AGENT_ACTION}" in
      [qQ]) exit 1 ;;
      [bB])
        mv "${dest}" "${dest}.$(date "+%s")"
        echo "Backup created for agent-zdotdir"
    esac
  fi
  ln -s -f "${src}" "${dest}"
  echo "agent-zdotdir was created"
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

  read -p "Are you sure install Vim plugins by vim-plug? [y/n]: " INSTALL_VIMPLUG_PLUGIN
  case "${INSTALL_VIMPLUG_PLUGIN}" in
    [nN]) exit 1 ;;
    [yY]) 
      vim -c 'let g:plug_window="" | PlugStatus | PlugClean | PlugUpdate | PlugInstall | quit'
      echo "Vim plugins was installed."
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

display_message "zsh env.d modules"
put_zsh_env_d

display_message "secrets setup"
setup_secrets

display_message "agent-zdotdir setup"
put_agent_zdotdir

display_message "Vim settings"
install_vim_plug
install_vim_plugin
