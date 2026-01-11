apply_service_guard() {
  for svc in "${DISABLE_SERVICES[@]}"; do
    systemctl disable --now "$svc" 2>/dev/null || true
  done

  for timer in "${DISABLE_TIMERS[@]}"; do
    systemctl disable --now "$timer" 2>/dev/null || true
  done

[[ "$KEEP_SYSTEMD_RESOLVED" == yes ]] && continue

}
