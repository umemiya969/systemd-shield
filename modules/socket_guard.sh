apply_socket_guard() {
  SOCKETS=(
    avahi-daemon.socket
    cups.socket
    systemd-rfkill.socket
  )

  for s in "${SOCKETS[@]}"; do
    systemctl disable "$s" 2>/dev/null || true
  done
}
