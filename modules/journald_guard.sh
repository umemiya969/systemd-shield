apply_journald_guard() {
  CONF="/etc/systemd/journald.conf"
  cp -a "$CONF" "$BACKUP/journald.conf.bak" 2>/dev/null || true

  case "$HW_PROFILE" in
    lowend) SIZE="50M" ;;
    mid)    SIZE="100M" ;;
    *)      SIZE="200M" ;;
  esac

  cat > "$CONF" <<EOF
[Journal]
Storage=persistent
Compress=yes
SystemMaxUse=$SIZE
RuntimeMaxUse=$SIZE
RateLimitIntervalSec=30s
RateLimitBurst=500
EOF

  systemctl restart systemd-journald
  echo "[OK] journald guarded ($SIZE)"
}
