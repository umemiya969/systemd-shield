detect_services() {

  USE_BLUETOOTH=0
  USE_PRINTER=0

  systemctl is-active bluetooth.service &>/dev/null && USE_BLUETOOTH=1
  systemctl is-active cups.service &>/dev/null && USE_PRINTER=1

  echo "[*] Bluetooth: $USE_BLUETOOTH | Printer: $USE_PRINTER"
}
