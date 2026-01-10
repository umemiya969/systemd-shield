apply_service_accounting_guard() {
  for dir in /etc/systemd/system/*.service.d; do
    mkdir -p "$dir"
    cat > "$dir/10-accounting.conf" <<EOF
[Service]
CPUAccounting=no
MemoryAccounting=no
IOAccounting=no
EOF
  done
}
