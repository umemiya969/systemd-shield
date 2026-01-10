#!/usr/bin/env bash
set -e

[[ $EUID -ne 0 ]] && echo "Run as root" && exit 1

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG="/var/log/systemd-shield.log"
BACKUP="/etc/systemd-shield-backup"

mkdir -p "$BACKUP"
exec > >(tee -a "$LOG") 2>&1

echo "[*] systemd-shield starting"

# LOAD DETECTORS
source "$BASE_DIR/detect/hardware.sh"
source "$BASE_DIR/detect/environment.sh"
source "$BASE_DIR/detect/services.sh"

# LOAD MODULES
source "$BASE_DIR/modules/journald_guard.sh"
source "$BASE_DIR/modules/oomd_guard.sh"
source "$BASE_DIR/modules/resource_guard.sh"
source "$BASE_DIR/modules/boot_guard.sh"
source "$BASE_DIR/modules/service_guard.sh"
source "$BASE_DIR/modules/rollback.sh"

detect_hardware
detect_environment
detect_services

apply_journald_guard
apply_oomd_guard
apply_resource_guard
apply_boot_guard
apply_service_guard

echo "[✓] systemd-shield applied successfully"
