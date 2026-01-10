apply_resource_guard() {
  mkdir -p /etc/systemd/system.conf.d

  cat > /etc/systemd/system.conf.d/99-shield.conf <<EOF
[Manager]
DefaultCPUAccounting=yes
DefaultMemoryAccounting=yes
DefaultTasksAccounting=yes
EOF

  systemctl daemon-reexec
  echo "[OK] resource accounting enabled"
}
