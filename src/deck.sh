#!/bin/env bash

declare -a ORIGINAL_DECK=( "Ace_of_Spades" "Two_of_Spades" "Three_of_Spades" "Four_of_Spades" "Five_of_Spades" "Six_of_Spades" "Seven_of_Spades" "Eight_of_Spades" "Nine_of_Spades" "Ten_of_Spades" "Jack_of_Spades" "Queen_of_Spades" "King_of_Spades" "Ace_of_Hearts" "Two_of_Hearts" "Three_of_Hearts" "Four_of_Hearts" "Five_of_Hearts" "Six_of_Hearts" "Seven_of_Hearts" "Eight_of_Hearts" "Nine_of_Hearts" "Ten_of_Hearts" "Jack_of_Hearts" "Queen_of_Hearts" "King_of_Hearts" "Ace_of_Diamonds" "Two_of_Diamonds" "Three_of_Diamonds" "Four_of_Diamonds" "Five_of_Diamonds" "Six_of_Diamonds" "Seven_of_Diamonds" "Eight_of_Diamonds" "Nine_of_Diamonds" "Ten_of_Diamonds" "Jack_of_Diamonds" "Queen_of_Diamonds" "King_of_Diamonds" "Ace_of_Clubs" "Two_of_Clubs" "Three_of_Clubs" "Four_of_Clubs" "Five_of_Clubs" "Six_of_Clubs" "Seven_of_Clubs" "Eight_of_Clubs" "Nine_of_Clubs" "Ten_of_Clubs" "Jack_of_Clubs" "Queen_of_Clubs" "King_of_Clubs" )
declare -A CARD_VALUES=( ["Ace_of_Spades"]=14 ["Two_of_Spades"]=2 ["Three_of_Spades"]=3 ["Four_of_Spades"]=4 ["Five_of_Spades"]=5 ["Six_of_Spades"]=6 ["Seven_of_Spades"]=7 ["Eight_of_Spades"]=8 ["Nine_of_Spades"]=9 ["Ten_of_Spades"]=10 ["Jack_of_Spades"]=11 ["Queen_of_Spades"]=12 ["King_of_Spades"]=13 ["Ace_of_Hearts"]=14 ["Two_of_Hearts"]=2 ["Three_of_Hearts"]=3 ["Four_of_Hearts"]=4 ["Five_of_Hearts"]=5 ["Six_of_Hearts"]=6 ["Seven_of_Hearts"]=7 ["Eight_of_Hearts"]=8 ["Nine_of_Hearts"]=9 ["Ten_of_Hearts"]=10 ["Jack_of_Hearts"]=11 ["Queen_of_Hearts"]=12 ["King_of_Hearts"]=13 ["Ace_of_Diamonds"]=14 ["Two_of_Diamonds"]=2 ["Three_of_Diamonds"]=3 ["Four_of_Diamonds"]=4 ["Five_of_Diamonds"]=5 ["Six_of_Diamonds"]=6 ["Seven_of_Diamonds"]=7 ["Eight_of_Diamonds"]=8 ["Nine_of_Diamonds"]=9 ["Ten_of_Diamonds"]=10 ["Jack_of_Diamonds"]=11 ["Queen_of_Diamonds"]=12 ["King_of_Diamonds"]=13 ["Ace_of_Clubs"]=14 ["Two_of_Clubs"]=2 ["Three_of_Clubs"]=3 ["Four_of_Clubs"]=4 ["Five_of_Clubs"]=5 ["Six_of_Clubs"]=6 ["Seven_of_Clubs"]=7 ["Eight_of_Clubs"]=8 ["Nine_of_Clubs"]=9 ["Ten_of_Clubs"]=10 ["Jack_of_Clubs"]=11 ["Queen_of_Clubs"]=12 ["King_of_Clubs"]=13 )
declare -a DECK

restore_deck() {
  log "Restoring deck"
  unset DECK
  for card in "${ORIGINAL_DECK[@]}"; do
    DECK+=("$card")
  done
}

print_deck() {
  log "Deck contains:"
  if [[ ${#DECK[@]} -eq 0 ]]; then
    log "Deck is empty"
    return 1
  fi

  for i in $(seq 1 ${#DECK[@]}); do
    printf '%s -> %s\t' "$i" "${DECK[$((i - 1))]}"
    if [[ $((i % 3 )) -eq 0 ]]; then 
      printf '\n'
    fi
  done
  printf '\n'
}

return_card() {
  DECK+=("$1")
}

draw_card() {
  if [[ ${#DECK[@]} -eq 0 ]]; then
    log "Deck is empty"
    return 1
  fi

  CARD=${DECK[0]}
  DECK=("${DECK[@]:1}")
}

shuffle() {
  log "Shuffling deck"
  if [[ ${#DECK[@]} -eq 0 ]]; then
    log "Deck is empty"
    return 1
  fi

  unset TMP_DECK
  for card in "${!DECK[@]}"; do
    TMP_DECK+=("${DECK[card]}")
  done
  unset DECK

  for card in "${!TMP_DECK[@]}"; do
    CARD=""
    while [ -z "$CARD"  ]; do
      ((num = RANDOM % 52))
      CARD=${TMP_DECK[num]} 
    done
    DECK+=("$CARD")
    TMP_DECK[num]=""
  done
  unset TMP_DECK
}
