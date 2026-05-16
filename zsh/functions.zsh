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
# tmux -t 用ターゲット（セッション名の完全一致）
# セッション名が ~ だけだと曖昧マッチで has-session が偽になり、
# duplicate session / no marked target の原因になる
##########################
_tmux_session_t() {
  print -r -- "=${1}"
}

##########################
# tmux セッション作成
##########################
tnew() {
  local dir session tt
  local src_pane src_session src_path src_panes target_home close_source_pane
  dir="${PWD}"
  session="$(basename "$dir")"

  if [ "$dir" = "$HOME" ]; then
    session="~"
  else
    session="$(basename "$dir")"
  fi
  tt=$(_tmux_session_t "$session")

  if [ -n "$TMUX" ]; then
    src_pane="$(tmux display-message -p '#{pane_id}' 2>/dev/null)"
    src_session="$(tmux display-message -p '#S' 2>/dev/null)"
    src_path="$(tmux display-message -p '#{pane_current_path}' 2>/dev/null)"
    src_panes="$(tmux display-message -p '#{window_panes}' 2>/dev/null)"

    # 既にtmux起動中(同名のセッションがあれば利用し、なければ作成)
    if tmux has-session -t "$tt" 2>/dev/null; then
      target_home="$(tmux show-options -qv -t "$tt" @tnew_home 2>/dev/null)"
      [[ -z "$target_home" ]] && target_home="$dir"
    else
      tmux new-session -d -s "$session" -c "$dir"
      tmux set-option -q -t "$tt" @tnew_home "$dir" 2>/dev/null
      target_home="$dir"
    fi

    close_source_pane=0
    if [[ -n "$src_pane" \
      && "$src_session" != "$session" \
      && "$src_path" = "$target_home" \
      && "$dir" = "$target_home" \
      && "${src_panes:-0}" -gt 1 ]]; then
      close_source_pane=1
    fi

    if tmux switch-client -t "$tt"; then
      [[ "$close_source_pane" = "1" ]] && tmux kill-pane -t "$src_pane" 2>/dev/null
    fi
  else
    # tmuxが起動していないとき
    if tmux has-session -t "$tt" 2>/dev/null; then
      tmux attach -t "$tt"
    else
      tmux new-session -d -s "$session" -c "$dir"
      tmux set-option -q -t "$tt" @tnew_home "$dir" 2>/dev/null
      tmux attach -t "$tt"
    fi
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

  # Codex ターミナルでは毎回選択させず、起動時の PWD に対応するセッションを使う
  if [[ -n "$CODEX_APP_TITLE" \
    || -n "$CODEX_THREAD_ID" \
    || "$CODEX_INTERNAL_ORIGINATOR_OVERRIDE" = "Codex Desktop" ]]; then
    tnew
    return
  fi

  if (( ${#sessions[@]} == 1 )); then
    tmux attach -t "$(_tmux_session_t "${sessions[1]}")"
    return
  fi

  tmux ls
  picked=$(_pick_tmux_session) || return 0
  [[ -n $picked ]] && tmux attach -t "$(_tmux_session_t "$picked")"
}
