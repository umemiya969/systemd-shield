#!/usr/bin/env bash

apply_logging_guard() {
  mkdir -p backups
  CONF="/etc/systemd/journald.conf"

  [[ -f "$CONF" ]] && cp "$CONF" "backups/journald.conf.bak"

  cat > "$CONF" <<EOF
[Journal]
SystemMaxUse=100M
RuntimeMaxUse=50M
Compress=yes
MaxLevelStore=warning
MaxLevelSyslog=warning
EOF

  systemctl restart systemd-journald
  echo "[+] Logging guard applied"
}
