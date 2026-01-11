#!/usr/bin/env bash

detect_dns_backend() {
  DNS_BACKEND="unknown"

  if systemctl is-active systemd-resolved >/dev/null 2>&1; then
    DNS_BACKEND="systemd-resolved"
    return
  fi

  if systemctl is-active NetworkManager >/dev/null 2>&1; then
    DNS_BACKEND="networkmanager"
    return
  fi

  if [[ -f /etc/resolv.conf ]] && grep -q "^nameserver" /etc/resolv.conf; then
    DNS_BACKEND="static"
    return
  fi
}
