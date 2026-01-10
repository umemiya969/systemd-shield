rollback() {
  echo "[!] Rolling back"

  for f in "$BACKUP"/*.bak; do
    cp -a "$f" "/etc/systemd/$(basename "$f" .bak)"
  done

  systemctl daemon-reexec
  systemctl restart systemd-journald
  systemctl restart systemd-oomd 2>/dev/null || true

  echo "[✓] rollback complete"
}
