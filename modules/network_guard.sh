#!/usr/bin/env bash
# systemd-shield - Network Guard
# Prevents network stack from being modified or disabled

NETWORK_PROTECTED_SERVICES=(
  "NetworkManager.service"
  "systemd-networkd.service"
  "systemd-resolved.service"
  "wpa_supplicant.service"
)

NETWORK_PROTECTED_TARGETS=(
  "network.target"
  "network-online.target"
)

network_guard_pre() {
  echo "[network-guard] Detecting active network services"

  ACTIVE_NETWORK_SERVICES=()

  for svc in "${NETWORK_PROTECTED_SERVICES[@]}"; do
    if systemctl is-active "$svc" >/dev/null 2>&1; then
      ACTIVE_NETWORK_SERVICES+=("$svc")
      echo "[network-guard] active: $svc"
    fi
  done

  export ACTIVE_NETWORK_SERVICES
}

network_guard_block() {
  local unit="$1"

  for protected in "${NETWORK_PROTECTED_SERVICES[@]}"; do
    if [[ "$unit" == "$protected" ]]; then
      echo "[network-guard] BLOCKED attempt to modify $unit"
      return 1
    fi
  done

  for target in "${NETWORK_PROTECTED_TARGETS[@]}"; do
    if [[ "$unit" == "$target" ]]; then
      echo "[network-guard] BLOCKED attempt to modify $unit"
      return 1
    fi
  done

  return 0
}

network_guard_post() {
  echo "[network-guard] Verifying network state"

  for svc in "${ACTIVE_NETWORK_SERVICES[@]}"; do
    if ! systemctl is-active "$svc" >/dev/null 2>&1; then
      echo "[network-guard] ERROR: $svc is no longer active"
      return 1
    fi
  done

  echo "[network-guard] Network stack healthy"
  return 0
}
