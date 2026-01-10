apply_manager_guard() {
  CONF="/etc/systemd/system.conf.d/99-systemd-shield.conf"
  mkdir -p /etc/systemd/system.conf.d

  cp -a "$CONF" "$BACKUP/manager_guard.bak" 2>/dev/null || true

  cat > "$CONF" <<EOF
[Manager]
DefaultTasksAccounting=no
DefaultMemoryAccounting=no
DefaultIOAccounting=no
DefaultIPAccounting=no
DefaultTimeoutStartSec=${BOOT_START:-15s}
DefaultTimeoutStopSec=${BOOT_STOP:-10s}
EOF

  systemctl daemon-reexec
}
