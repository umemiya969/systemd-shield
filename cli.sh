#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

COMMAND="$1"
PROFILE="$2"

source "$ROOT_DIR/core/loader.sh"

case "$COMMAND" in
  apply)
    apply_profile "$PROFILE"
    ;;
  status)
    show_status
    ;;
  rollback)
    rollback_all
    ;;
  *)
    echo "Usage:"
    echo "  ./cli.sh apply <profile>"
    echo "  ./cli.sh status"
    echo "  ./cli.sh rollback"
    exit 1
    ;;
esac
