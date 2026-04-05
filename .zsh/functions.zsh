##########################
# 共通
##########################
function load_files_if_exists() {
  local file
  for file in ${@}; do
    [ -r ${file} ] && source ${file}
  done
}

##########################
# tmux セッション作成
##########################
tnew() {
  local dir session
  dir="${PWD}"
  session="$(basename "$dir")"

  if [ "$dir" = "$HOME" ]; then
    session="~"
  else
    session="$(basename "$dir")"
  fi

  if [ -n "$TMUX" ]; then
    # 既にtmux起動中(同名のセッションがあれば利用し、なければ作成)
    tmux has-session -t "$session" 2>/dev/null \
      || tmux new-session -d -s "$session" -c "$dir"
    tmux switch-client -t "$session"
  else
    # tmuxが起動していないとき
    tmux new-session -A -s "$session" -c "$dir"
  fi
}

##########################
# tmux セッション選択（複数あるとき）
# fzf があれば対話選択（Tab/Shift-Tab で候補移動）。無ければ select。
# （read -e -c は環境によっては ZLE/補完モジュールの都合で使えないため未使用）
##########################
_pick_tmux_session() {
  local -a sessions
  sessions=(${(f)"$(tmux ls -F '#S' 2>/dev/null)"})
  (( ${#sessions[@]} == 0 )) && return 1
  (( ${#sessions[@]} == 1 )) && { print -r -- "$sessions[1]"; return 0 }

  if command -v fzf >/dev/null 2>&1; then
    printf '%s\n' "${sessions[@]}" | fzf \
      --prompt='Session> ' \
      --height=40% \
      --layout=reverse \
      --border \
      --bind=tab:down,btab:up
    return
  fi

  local session
  PS3='Choose session (number): '
  select session in "${sessions[@]}"; do
    [[ -n $session ]] && { print -r -- "$session"; return 0 }
    break
  done
  return 1
}

##########################
# tmux 自動起動 / アタッチ
# （インタラクティブかつ VS Code ターミナル以外で TMUX 未設定のとき）
##########################
zsh_tmux_autostart() {
  command -v tmux >/dev/null || return 0

  local -a sessions
  local picked

  if ! tmux ls -F '#S' >/dev/null 2>&1; then
    # サーバなし or セッションなし → tnew で最初のセッション名を ~ などに揃える
    tnew
    return
  fi

  sessions=(${(f)"$(tmux ls -F '#S' 2>/dev/null)"})
  (( ${#sessions[@]} == 0 )) && { tnew; return; }

  if (( ${#sessions[@]} == 1 )); then
    tmux attach -t "${sessions[1]}"
    return
  fi

  tmux ls
  picked=$(_pick_tmux_session) || return 0
  [[ -n $picked ]] && tmux attach -t "$picked"
}
