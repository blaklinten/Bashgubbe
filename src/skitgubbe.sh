#!/bin/env bash

source ../utils/logging.sh
source ../utils/clean_up.sh
source ./deck.sh
source ./player_state.sh


restore_deck
shuffle
init_player_state
print_player_one_state
print_player_two_state
print_deck
clean_up
