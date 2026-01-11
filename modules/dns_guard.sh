#!/usr/bin/env bash

apply_dns_guard() {
  detect_dns_backend

  case "$DNS_BACKEND" in
    systemd-resolved)
      echo "[DNS] systemd-resolved active (keeping it)"
      systemctl enable --now systemd-resolved.service
      ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
      ;;
    networkmanager)
      echo "[DNS] NetworkManager handles DNS"
      ;;
    static)
      echo "[DNS] Static resolv.conf detected"
      ;;
    *)
      echo "[DNS] No DNS backend detected, applying fallback"
      cat > /etc/resolv.conf <<EOF
nameserver 1.1.1.1
nameserver 8.8.8.8
EOF
      ;;
  esac
}
