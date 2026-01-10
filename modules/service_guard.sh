apply_service_guard() {

  if [[ "$USE_BT" -eq 0 ]]; then
    systemctl disable --now bluetooth.service 2>/dev/null || true
    echo "[OK] bluetooth disabled"
  fi

  if [[ "$USE_PRINTER" -eq 0 ]]; then
    systemctl disable --now cups.service 2>/dev/null || true
    echo "[OK] cups disabled"
  fi
}
