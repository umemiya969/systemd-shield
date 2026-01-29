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
source "$BASE_DIR/modules/manager_guard.sh"
source "$BASE_DIR/modules/service_accounting_guard.sh"
source "$BASE_DIR/modules/socket_guard.sh"
source "$BASE_DIR/modules/user_guard.sh"
source "$BASE_DIR/modules/network_guard.sh"


detect_hardware
detect_environment
detect_services
apply_manager_guard
apply_service_accounting_guard
apply_socket_guard
apply_user_guard
apply_journald_guard
apply_oomd_guard
apply_resource_guard
apply_boot_guard
apply_service_guard
apply_network_guard

echo "[✓] systemd-shield applied successfully"
