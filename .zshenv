# Keep this file fast and side-effect free. It is loaded by every zsh.

typeset -U path PATH

_zshenv_path=()
for _dir in \
  "$HOME/.local/bin" \
  "$HOME/bin" \
  "$HOME/.asdf/shims" \
  /opt/homebrew/bin \
  /opt/homebrew/sbin \
  /usr/local/bin \
  /usr/local/sbin
do
  [[ -d "$_dir" ]] && _zshenv_path+=("$_dir")
done

path=($_zshenv_path $path)
unset _dir _zshenv_path

export PATH
