#!/usr/bin/env bash

apply_oomd_guard() {
  CONF="/etc/systemd/oomd.conf"
  cp -a "$CONF" "$BACKUP/oomd.conf.bak" 2>/dev/null || true

  cat > "$CONF" <<EOF
[OOM]
DefaultMemoryPressureLimit=60%
EOF

  systemctl restart systemd-oomd 2>/dev/null || true
  echo "[OK] oomd guarded"
}
