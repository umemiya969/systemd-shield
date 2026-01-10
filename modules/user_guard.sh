apply_user_guard() {
  CONF="/etc/systemd/user.conf.d/systemd-shield.conf"
  mkdir -p /etc/systemd/user.conf.d

  cat > "$CONF" <<EOF
[Manager]
DefaultTasksMax=15%
EOF
}
