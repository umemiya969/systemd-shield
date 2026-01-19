#!/usr/bin/env bash

apply_dependency_guard() {
  systemctl disable NetworkManager-wait-online.service 2>/dev/null || true
  systemctl disable systemd-networkd-wait-online.service 2>/dev/null || true

  echo "[+] Dependency guard applied (wait-online disabled)"
}
