#!/usr/bin/env bash
set -e

PROFILE="$1"

if [[ $EUID -ne 0 ]]; then
  echo "Run as root"
  exit 1
fi

if [[ -z "$PROFILE" ]]; then
  echo "Usage: sudo ./systemd-shield.sh <profile>"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$BASE_DIR/modules/logging_guard.sh"
source "$BASE_DIR/modules/resource_guard.sh"
source "$BASE_DIR/modules/dependency_guard.sh"

echo "[*] Applying systemd-shield profile: $PROFILE"

apply_logging_guard "$PROFILE"
apply_resource_guard "$PROFILE"
apply_dependency_guard "$PROFILE"

echo "[✓] systemd-shield applied successfully"
echo "Reboot recommended"
