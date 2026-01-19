#!/usr/bin/env bash
# systemd-shield - dns_mode
# Purpose:
# - Manage DNS safely
# - Prevent broken resolv.conf
# - Support sysinit-like simplicity without killing networking

apply_dns_mode() {

  DNS_MODE="${DNS_MODE:-systemd}"

  echo "[dns_mode] Applying DNS mode: $DNS_MODE"

  case "$DNS_MODE" in
    systemd)
      echo "[dns_mode] Using systemd-resolved"

      systemctl enable --now systemd-resolved.service >/dev/null 2>&1 || true

      ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
      ;;

    static)
      echo "[dns_mode] Using static resolv.conf"

      systemctl disable --now systemd-resolved.service >/dev/null 2>&1 || true

      cat >/etc/resolv.conf <<EOF
nameserver 1.1.1.1
nameserver 8.8.8.8
options timeout:2 attempts:3
EOF
      chmod 644 /etc/resolv.conf
      ;;

    nm)
      echo "[dns_mode] Using NetworkManager DNS"

      systemctl enable --now NetworkManager.service >/dev/null 2>&1 || true
      systemctl disable --now systemd-resolved.service >/dev/null 2>&1 || true

      ln -sf /run/NetworkManager/resolv.conf /etc/resolv.conf
      ;;

    *)
      echo "[dns_mode] ERROR: Unknown DNS_MODE '$DNS_MODE'"
      echo "[dns_mode] Valid modes: systemd | static | nm"
      return 1
      ;;
  esac

  # Sanity check
  if [[ ! -s /etc/resolv.conf ]]; then
    echo "[dns_mode] ERROR: resolv.conf is empty!"
    return 1
  fi

  echo "[dns_mode] DNS configuration applied safely"
}
