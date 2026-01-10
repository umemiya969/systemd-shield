apply_journald_guard() {
  CONF="/etc/systemd/journald.conf.d/systemd-shield.conf"
  mkdir -p /etc/systemd/journald.conf.d

  cp -a "$CONF" "$BACKUP/journald_guard.bak" 2>/dev/null || true

  cat > "$CONF" <<EOF
[Journal]
Storage=volatile
Compress=yes
Seal=no
SyncIntervalSec=5m
RateLimitIntervalSec=30s
RateLimitBurst=500
SystemMaxUse=${JOURNAL_SIZE:-50M}
EOF

  systemctl restart systemd-journald
}
