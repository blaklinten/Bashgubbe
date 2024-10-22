#!/bin/env bash

source ./graphics.sh
source ./deck.sh
source ./player_state.sh
source ../utils/logging.sh

declare WINNER
declare PLAYER_TURN
declare PHASE
declare -a PILE

start_game() {
  PLAYER_TURN=1
  PHASE=1
  draw_card
  PILE=("$CARD" "${PILE[@]}")
}

play_card() {
  read -s -r -n1 -p "Choose card to play!"
  get_player_card "$PHASE" "$PLAYER_TURN" "$REPLY"
  log "Played card: $PLAYER_CARD"
  if validate_played_card "$PLAYER_CARD"; then
    log "Card is valid - next player turn!"
    PILE=("$PLAYER_CARD" "${PILE[@]}")
    player_draw_card "$PHASE" "$PLAYER_TURN" "$REPLY"
  else
    log "Card is not valid, the pile is transferred to player"
    player_take_pile "$PLAYER_TURN"
  fi
}

validate_played_card() {
  if [ "${#PILE[@]}" -eq 0 ];then
    log "Pile is empty - all cards are valid"
    return 0
  fi

  CARD_VALUE=${CARD_VALUES[$1]}
  log "Card value is $CARD_VALUE"

  PILE_VALUE=${CARD_VALUES[${PILE[0]}]}
  log "Pile value is $PILE_VALUE"

  if [ "$CARD_VALUE" -eq 2 ] && [ "$PILE_VALUE" -ne 2 ]; then
    log "Valid value 2 - get second card"
    PILE=("$PLAYER_CARD" "${PILE[@]}")
    player_draw_card "$PHASE" "$PLAYER_TURN" "$REPLY"
    play_card
    return 0
  elif [ "$CARD_VALUE" -eq 2 ] && [ "$PILE_VALUE" -eq 2  ]; then
    return 1
  fi

  if [ "$CARD_VALUE" -ge "$PILE_VALUE" ];then
    return 0
  else
    return 1
  fi
}

next_turn() {
  log "Next turn: player $PLAYER_TURN"

  render_player "$PHASE" "$PLAYER_TURN"
  play_card "$PHASE" "$PLAYER_TURN"

  if [[ "$PHASE" -eq 1 ]] && [[ ${#DECK[@]} -eq 0 ]];then
    log "Deck is empty - going to phase 2"
    PHASE=2
  elif player_has_no_card_left "$PLAYER_TURN"; then
    log "Player $PLAYER_TURN has no cards left - this is the winner!"
    WINNER="$PLAYER_TURN"
  fi

  case "$PLAYER_TURN" in
    "1")
      PLAYER_TURN=2
      ;;
    "2")
      PLAYER_TURN=1
      ;;
  esac
}
