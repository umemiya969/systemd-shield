#!/usr/bin/env bash

assert_root() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "Must be run as root"
    exit 1
  fi
}
