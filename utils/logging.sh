#!/bin/env bash

log() {
  if [[ -z "$LOG_ENABLED" ]]; then
    return 0
  fi

  printf '%s\n' "$@"
}

