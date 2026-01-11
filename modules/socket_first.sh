#!/usr/bin/env bash

apply_socket_first() {
  for svc in "${SOCKET_FIRST_SERVICES[@]}"; do
    if systemctl list-unit-files | grep -q "$svc.socket"; then
      systemctl enable "$svc.socket"
      systemctl disable "$svc.service"
    fi
  done
}
