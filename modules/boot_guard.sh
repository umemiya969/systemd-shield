apply_boot_guard() {
  mkdir -p /etc/systemd/system.conf.d

  cat > /etc/systemd/system.conf.d/98-boot.conf <<EOF
[Manager]
DefaultTimeoutStartSec=15s
DefaultTimeoutStopSec=10s
EOF

  systemctl daemon-reexec
  echo "[OK] boot optimized"
}
