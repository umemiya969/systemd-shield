#!/usr/bin/env bash

apply_resource_guard() {
  if [[ "$ENABLE_GLOBAL_ACCOUNTING" == "no" ]]; then
    mkdir -p /etc/systemd/system.conf.d

    cat > /etc/systemd/system.conf.d/10-shield.conf <<EOF
[Manager]
DefaultCPUAccounting=no
DefaultMemoryAccounting=no
DefaultIOAccounting=no
EOF
  fi
}
