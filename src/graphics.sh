#!/bin/env bash

build_header() {
  printf 'Player %s: %s\n' "$1" "$2"
}

prepare_player() {
  clear_screen
  build_header "$1" "press any key to start your turn!"
  read -r -n1 -s
  clear_screen
}

render_player_state() {
  # Phase 1
  printf 'Pile: %s\nAnswer d to take a chance on the deck' "${PILE[0]}"

  case "$2" in
    "1")
      printf 'Player one hand:\n'
      for i in $(seq 1 ${#PLAYER_ONE_HAND[@]}); do
        printf '%s -> %s\t' "$i" "${PLAYER_ONE_HAND[$((i - 1))]}"
      done
      printf '\n'

      printf 'Player one open cards:\n'
      for i in $(seq 1 ${#PLAYER_ONE_OPEN[@]}); do
        printf '%s -> %s\t' "$i" "${PLAYER_ONE_OPEN[$((i - 1))]}"
      done
      printf '\n'
      ;;
    "2")
      printf 'Player two hand:\n'
      for i in $(seq 1 ${#PLAYER_TWO_HAND[@]}); do
        printf '%s -> %s\t' "$i" "${PLAYER_TWO_HAND[$((i - 1))]}"
      done
      printf '\n'

      printf 'Player two open cards:\n'
      for i in $(seq 1 ${#PLAYER_TWO_OPEN[@]}); do
        printf '%s -> %s\t' "$i" "${PLAYER_TWO_OPEN[$((i - 1))]}"
      done
      printf '\n'
      ;;
  esac

}

render_player() {
  PHASE="$1"
  PLAYER="$2"

  prepare_player "$PLAYER"
  render_player_state "$PHASE" "$PLAYER"
}

render_error() {
  clear_screen
  build_header "$PLAYER" "$1"
  read -r -n1 -s
  clear_screen
}

print_winner() {
  clear_screen
  printf '\t\t\tCongratulations, player %s won!\n' "$1"
}
