#!/bin/env bash

source ../utils/logging.sh
source ./deck.sh


restore_deck
print_deck
shuffle
print_deck
draw_card
log "I got card: [$CARD]"
print_deck
return_card "$CARD"
print_deck
