#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/safety.sh"
source "$ROOT_DIR/core/logger.sh"
source "$ROOT_DIR/core/rollback.sh"

apply_profile() {
  assert_root

  local profile="$1"
  [[ -z "$profile" ]] && {
    log_error "No profile specified"
    exit 1
  }

  source "$ROOT_DIR/profiles/$profile.conf"

  load_modules
}

load_modules() {
  for module in "${MODULES[@]}"; do
    source "$ROOT_DIR/modules/$module.sh"
    "apply_$module"
  done
}

show_status() {
  log_info "systemd-shield is installed"
}
