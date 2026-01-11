#!/usr/bin/env bash

apply_target_hygiene() {
  mkdir -p /etc/systemd/system/multi-user.target.d

  cat > /etc/systemd/system/multi-user.target.d/10-shield.conf <<EOF
[Unit]
Wants=
EOF
}
