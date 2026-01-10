apply_resource_guard() {
  TARGETS=(
    "packagekit.service"
    "tracker-miner-fs.service"
  )

  for svc in "${TARGETS[@]}"; do
    DIR="/etc/systemd/system/$svc.d"
    mkdir -p "$DIR"

    cat > "$DIR/override.conf" <<EOF
[Service]
CPUQuota=20%
MemoryHigh=300M
IOSchedulingClass=idle
EOF
  done

  systemctl daemon-reexec
  echo "[+] Resource guard applied"
}
