#!/usr/bin/env bash

apply_journald_guard() {
  mkdir -p /etc/systemd/journald.conf.d

  cat > /etc/systemd/journald.conf.d/10-shield.conf <<EOF
[Journal]
Storage=$JOURNAL_STORAGE
RuntimeMaxUse=$JOURNAL_MAX
Compress=no
RateLimitIntervalSec=30s
RateLimitBurst=200
ForwardToSyslog=no
EOF

  systemctl restart systemd-journald
}
