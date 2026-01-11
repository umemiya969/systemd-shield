detect_environment() {
  if loginctl show-session "$(loginctl | awk 'NR==2 {print $1}')" -p Type | grep -q x11; then
    SESSION_TYPE="desktop"
  else
    SESSION_TYPE="server"
  fi

  if systemctl is-active NetworkManager >/dev/null; then
  KEEP_SYSTEMD_RESOLVED=yes
  fi

  echo "[*] Environment: $SESSION_TYPE | Network: $NET_STACK"
}
