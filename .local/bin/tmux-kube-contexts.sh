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

debug_print() {
  # show the 256 colors
  if [ "${1}" == "1" ]; then
    for num in {0..255}; do printf "%s\033[38;5;${num}mcolour${num}\033[0m \t"; [ $(expr $((num+1)) % 8) -eq 0 ] && printf "\n"; done
  fi

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
  local fg=${!fg_color_variable}
  local bg=${!bg_color_variable}
  local bold=$( [ "${!bold_variable}" == "1" ] && echo ",bold" || echo "" )
  echo "#[fg=colour${fg},bg=colour${bg}${bold}] ⎈ ${context} #[default]"
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

