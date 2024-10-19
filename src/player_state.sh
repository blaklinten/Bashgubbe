#!/bin/env bash

source ./deck.sh
source ../utils/logging.sh

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
