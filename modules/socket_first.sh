#!/usr/bin/env bash
# systemd-shield - socket_first
# Purpose:
# - Convert eligible services to socket-activated mode
# - Reduce idle daemons (sysinit-like behavior)
# - Never break core system functionality

apply_socket_first() {
  SOCKET_FIRST_SERVICES=("${SOCKET_FIRST_SERVICES[@]}")

  # Services that must NEVER be socket-forced
  PROTECTED_SERVICES=(
    NetworkManager
    systemd-resolved
    systemd-networkd
    dbus
    systemd-logind
    systemd-udevd
  )

  for name in "${SOCKET_FIRST_SERVICES[@]}"; do
    [[ -z "$name" ]] && continue

    service="${name}.service"
    socket="${name}.socket"

    # Skip protected services
    for protected in "${PROTECTED_SERVICES[@]}"; do
      if [[ "$name" == "$protected" ]]; then
        echo "[socket_first] Skipping protected service: $service"
        continue 2
      fi
    done

    # Check socket existence
    if ! systemctl list-unit-files | grep -q "^$socket"; then
      echo "[socket_first] No socket found for $service, skipping"
      continue
    fi

    # Enable socket first
    echo "[socket_first] Enabling socket: $socket"
    systemctl enable "$socket" >/dev/null 2>&1 || {
      echo "[socket_first] Failed to enable socket for $service, skipping"
      continue
    }

    # Disable service if socket enabled successfully
    echo "[socket_first] Disabling service: $service (socket-activated)"
    systemctl disable "$service" >/dev/null 2>&1 || true
  done
}
