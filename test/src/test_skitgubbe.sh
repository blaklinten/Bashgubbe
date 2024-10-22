#!/bin/env bash

log() {
  if [[ -z "$LOG_ENABLED" ]]; then
    return 0
  fi
  printf '%s\n' "$@"
}

clear_screen() {
  if [[ -n "$LOG_ENABLED" ]]; then
    return 0
  fi
  clear
}

#!/bin/env bash

clean_up() {
  unset DECK
  unset ORIGINAL_DECK
  unset TMP_DECK
  unset CARD
  unset PLAYER_ONE_HAND
  unset PLAYER_ONE_HAND
  unset PLAYER_ONE_HAND
  unset PLAYER_ONE_OPEN
  unset PLAYER_ONE_OPEN
  unset PLAYER_ONE_OPEN
  unset PLAYER_ONE_HIDDEN
  unset PLAYER_ONE_HIDDEN
  unset PLAYER_ONE_HIDDEN
  unset PLAYER_TWO_HAND
  unset PLAYER_TWO_HAND
  unset PLAYER_TWO_HAND
  unset PLAYER_TWO_OPEN
  unset PLAYER_TWO_OPEN
  unset PLAYER_TWO_OPEN
  unset PLAYER_TWO_HIDDEN
  unset PLAYER_TWO_HIDDEN
  unset PLAYER_TWO_HIDDEN
  unset WINNER
  unset PLAYER_TURN
  unset PHASE
}
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
#!/bin/env bash






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
  REPLY=1
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
#!/bin/env bash




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
#!/bin/env bash

build_header() {
  printf 'Player %s: %s\n' "$1" "$2"
}

prepare_player() {
  clear_screen
  build_header "$1" "press any key to start your turn!"
  REPLY=1
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
  REPLY=1
  clear_screen
}

print_winner() {
  clear_screen
  printf '\t\t\tCongratulations, player %s won!\n' "$1"
}
#!/bin/env bash


clean_up






restore_deck
shuffle
init_player_state
start_game
while [ -z "$WINNER" ]; do
  next_turn
done

print_winner "$WINNER"

clean_up
