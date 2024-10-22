#!/bin/env bash

source ./deck.sh
source ../utils/logging.sh

declare PLAYER_ONE_HAND
declare PLAYER_ONE_OPEN
declare PLAYER_ONE_HIDDEN
declare PLAYER_TWO_HAND
declare PLAYER_TWO_OPEN
declare PLAYER_TWO_HIDDEN
declare PLAYER_CARD

init_player_state() {
  draw_card
  PLAYER_ONE_HAND+=("$CARD")
  draw_card
  PLAYER_ONE_HAND+=("$CARD")
  draw_card
  PLAYER_ONE_HAND+=("$CARD")

  draw_card
  PLAYER_ONE_HIDDEN+=("$CARD")
  draw_card
  PLAYER_ONE_HIDDEN+=("$CARD")
  draw_card
  PLAYER_ONE_HIDDEN+=("$CARD")

  draw_card
  PLAYER_ONE_OPEN+=("$CARD")
  draw_card
  PLAYER_ONE_OPEN+=("$CARD")
  draw_card
  PLAYER_ONE_OPEN+=("$CARD")

  draw_card
  PLAYER_TWO_HAND+=("$CARD")
  draw_card
  PLAYER_TWO_HAND+=("$CARD")
  draw_card
  PLAYER_TWO_HAND+=("$CARD")

  draw_card
  PLAYER_TWO_HIDDEN+=("$CARD")
  draw_card
  PLAYER_TWO_HIDDEN+=("$CARD")
  draw_card
  PLAYER_TWO_HIDDEN+=("$CARD")

  draw_card
  PLAYER_TWO_OPEN+=("$CARD")
  draw_card
  PLAYER_TWO_OPEN+=("$CARD")
  draw_card
  PLAYER_TWO_OPEN+=("$CARD")
}

get_player_card() {
  PHASE="$1"

  if [ "$3" = "d" ] && [ "$PHASE" -eq 1 ];then
    draw_card
    PLAYER_CARD="$CARD"
    return
  fi

  PLAYER="$2"
  CARD_NUM="(($3 - 1))"

  case "$PHASE" in
    1)
      case "$PLAYER" in
        1)
          PLAYER_CARD="${PLAYER_ONE_HAND[CARD_NUM]}"
          ;;
        2)
          PLAYER_CARD="${PLAYER_TWO_HAND[CARD_NUM]}"
          ;;
      esac
      ;;
    *)
      log "Not implemented"
      exit 1
      ;;
  esac
}

player_draw_card() {
  PHASE="$1"
  PLAYER="$2"
  CARD_NUM="(($3 - 1))"

  [ "$PHASE" -eq 2 ] && return

  case "$PLAYER" in
    1)
      [ "${#PLAYER_ONE_HAND[@]}" -ge 3 ] && return
      draw_card
      PLAYER_ONE_HAND[CARD_NUM]="$CARD"
      ;;
    2)
      [ "${#PLAYER_TWO_HAND[@]}" -ge 3 ] && return
      draw_card
      PLAYER_TWO_HAND[CARD_NUM]="$CARD"
      ;;
  esac
}

player_has_no_card_left() {
  case "$1" in
    "1")
      if [[ ${#PLAYER_ONE_HAND[@]} -eq 0 ]] && [[ ${#PLAYER_ONE_OPEN[@]} -eq 0 ]] && [[ ${#PLAYER_ONE_HIDDEN[@]} -eq 0 ]]; then
        log "Player one has no more cards!"
        return 0
      else
        log "Player one has more cards."
        return 1
      fi
      ;;
    "2")
      if [[ ${#PLAYER_TWO_HAND[@]} -eq 0 ]] && [[ ${#PLAYER_TWO_OPEN[@]} -eq 0 ]] && [[ ${#PLAYER_TWO_HIDDEN[@]} -eq 0 ]]; then
        log "Player two has no more cards!"
        return 0
      else
        log "Player two has more cards."
        return 1
      fi
      ;;
  esac
}

print_player_one_state() {
  log "Player one hand:"
  for i in $(seq 1 ${#PLAYER_ONE_HAND[@]}); do
    printf '%s -> %s\t' "$i" "${PLAYER_ONE_HAND[$((i - 1))]}"
  done
  printf '\n'

  log "Player one hidden:"
  for i in $(seq 1 ${#PLAYER_ONE_HIDDEN[@]}); do
    printf '%s -> %s\t' "$i" "${PLAYER_ONE_HIDDEN[$((i - 1))]}"
  done
  printf '\n'

  log "Player one open:"
  for i in $(seq 1 ${#PLAYER_ONE_OPEN[@]}); do
    printf '%s -> %s\t' "$i" "${PLAYER_ONE_OPEN[$((i - 1))]}"
  done
  printf '\n'
}

print_player_two_state() {
  log "Player two hand:"
  for i in $(seq 1 ${#PLAYER_TWO_HAND[@]}); do
    printf '%s -> %s\t' "$i" "${PLAYER_TWO_HAND[$((i - 1))]}"
  done
  printf '\n'

  log "Player two hidden:"
  for i in $(seq 1 ${#PLAYER_TWO_HIDDEN[@]}); do
    printf '%s -> %s\t' "$i" "${PLAYER_TWO_HIDDEN[$((i - 1))]}"
  done
  printf '\n'

  log "Player two open:"
  for i in $(seq 1 ${#PLAYER_TWO_OPEN[@]}); do
    printf '%s -> %s\t' "$i" "${PLAYER_TWO_OPEN[$((i - 1))]}"
  done
  printf '\n'
}

player_take_pile() {
  PLAYER="$1"

  log "Player $PLAYER takes the pile"
  case "$PLAYER" in
    1)
      PLAYER_ONE_HAND+=("${PILE[@]}")
      ;;
    2)
      PLAYER_TWO_HAND+=("${PILE[@]}")
      ;;
  esac
  PILE=()
}
