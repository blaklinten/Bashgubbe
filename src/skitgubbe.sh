#!/bin/env bash

source ../utils/clean_up.sh
clean_up

source ./deck.sh
source ./player_state.sh
source ./game.sh
source ../utils/logging.sh

restore_deck
shuffle
init_player_state
start_game
while [ -z "$WINNER" ]; do
  next_turn
done

print_winner "$WINNER"

clean_up
