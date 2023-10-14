#!/usr/bin/env bash

dev_fg_color="255"
dev_bg_color="27"
dev_bold=1

test_fg_color="255"
test_bg_color="28"
test_bold=1

stg_fg_color="255"
stg_bg_color="136"
stg_bold=1

prod_fg_color="255"
prod_bg_color="200"
prod_bold=1

context_cutoff_length=20
empty_context_string="-"

kube_context=""

get_ansi_escape_code_fg() {
  # The 38 is to set foreground color
  echo $(get_ansi_escape_code 38 ${1})
}

get_ansi_escape_code_bg() {
  # The 48 is to set background color
  echo $(get_ansi_escape_code 48 ${1})
}

get_ansi_escape_code() {
  # SGR (Select Graphic Rendition) parameters
  # https://en.wikipedia.org/wiki/ANSI_escape_code#SGR
  sgr_param=${1}
  # 256 colors
  # https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
  color_code=${2}
  echo -e "\033[${sgr_param};5;${color_code}m"
}

get_ansi_escape_code_bold() {
  echo -e "\033[1m"
}

get_ansi_escape_code_reset() {
  echo -e "\033[0m"
}

debug_print() {
  # show the 256 colors
  if [ "${1}" == "1" ]; then
    for num in {0..255}; do printf "%s\033[38;5;${num}mcolour${num}\033[0m \t"; [ $(expr $((num+1)) % 8) -eq 0 ] && printf "\n"; done
  fi

  local dev_fg=$(get_ansi_escape_code_fg ${dev_fg_color})
  local dev_bg=$(get_ansi_escape_code_bg ${dev_bg_color})
  local test_fg=$(get_ansi_escape_code_fg ${test_fg_color})
  local test_bg=$(get_ansi_escape_code_bg ${test_bg_color})
  local stg_fg=$(get_ansi_escape_code_fg ${stg_fg_color})
  local stg_bg=$(get_ansi_escape_code_bg ${stg_bg_color})
  local prod_fg=$(get_ansi_escape_code_fg ${prod_fg_color})
  local prod_bg=$(get_ansi_escape_code_bg ${prod_bg_color})
  local reset=$(get_ansi_escape_code_reset)

  printf "$(get_output "dev-env" "dev")\n"
  printf "$(get_output "test-env" "test")\n"
  printf "$(get_output "stg-env" "stg")\n"
  printf "$(get_output "prod-env" "prod")\n"

  printf "$(get_output "" "dev")\n"
  printf "$(get_output "long-context-name-abcdefghijklmnopqrstuvwxyz0123456789" "dev")\n"
}


get_kube_context() {
  if [ -n "${kube_context}" ]; then
    echo ${kube_context}
  else
    [ -x "$(command -v kubectl)" ] || return 0
    kube_context=$(kubectl config current-context)
    echo ${kube_context}
  fi
}

get_context_env() {
  local kube_context=$(get_kube_context)
  case "${kube_context}" in
    *prod*)
      echo "prod"
      ;;
    *stg*|*stage*)
      echo "stg"
      ;;
    *test*)
      echo "test"
      ;;
    *)
      echo "dev"
      ;;
  esac
}

get_output_context_string() {
  local original=${1:-"${empty_context_string}"}

  local cut_string="${original:0:$context_cutoff_length}"
  [ "${#cut_string}" -eq "${context_cutoff_length}" ] && [ "${cut_string}" != "${original}" ] && cut_string+="..."

  echo ${cut_string}
}

get_output() {
  local context=$(get_output_context_string ${1})
  local env=${2}
  local fg_color_variable="${env}_fg_color"
  local bg_color_variable="${env}_bg_color"
  local bold_variable="${env}_bold"
  local bold=$( [ "${!bold_variable}" == "1" ] && get_ansi_escape_code_bold || echo "" )
  local fg=$(get_ansi_escape_code_fg ${!fg_color_variable})
  local bg=$(get_ansi_escape_code_bg ${!bg_color_variable})
  reset=$(get_ansi_escape_code_reset)
  echo "${fg}${bg}${bold} ⎈ ${context} ${reset}"
}

for arg in "$@"; do
  case "$arg" in
    --debug)
      debug_print
      exit 0
      ;;
    --debug-with-color-code)
      debug_print 1
      exit 0
      ;;
  esac
done

echo -e $(get_output $(get_kube_context) $(get_context_env))

