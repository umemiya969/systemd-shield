#!/usr/bin/env bash
# systemd-shield - service_guard
# Purpose:
# - Disable non-critical services and timers
# - Never break networking, DNS, or core system functionality
# - Behave safely in sysinit-like mode

apply_service_guard() {
  # Safety: arrays may be empty
  DISABLE_SERVICES=("${DISABLE_SERVICES[@]}")
  DISABLE_TIMERS=("${DISABLE_TIMERS[@]}")

  # Services that must NEVER be disabled
  PROTECTED_SERVICES=(
    systemd-resolved.service
    NetworkManager.service
    systemd-networkd.service
    dbus.service
    systemd-logind.service
    systemd-udevd.service
  )

  # --- Disable services ---
  for svc in "${DISABLE_SERVICES[@]}"; do
    [[ -z "$svc" ]] && continue

    # Skip protected services
    for protected in "${PROTECTED_SERVICES[@]}"; do
      if [[ "$svc" == "$protected" ]]; then
        echo "[service_guard] Skipping protected service: $svc"
        continue 2
      fi
    done

    # Disable only if unit exists
    if systemctl list-unit-files | grep -q "^$svc"; then
      echo "[service_guard] Disabling service: $svc"
      systemctl disable --now "$svc" >/dev/null 2>&1 || true
    fi
  done

  # --- Disable timers ---
  for timer in "${DISABLE_TIMERS[@]}"; do
    [[ -z "$timer" ]] && continue

    if systemctl list-unit-files | grep -q "^$timer"; then
      echo "[service_guard] Disabling timer: $timer"
      systemctl disable --now "$timer" >/dev/null 2>&1 || true
    fi
  done
}
