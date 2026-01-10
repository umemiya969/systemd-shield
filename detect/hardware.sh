detect_hardware() {
  MEM_MB=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)
  CPU_CORES=$(nproc)

  if [[ $MEM_MB -lt 4096 ]]; then
    HW_PROFILE="lowend"
  elif [[ $MEM_MB -lt 8192 ]]; then
    HW_PROFILE="mid"
  else
    HW_PROFILE="high"
  fi

  if lsblk -d -o rota | grep -q 1; then
    DISK_TYPE="hdd"
  else
    DISK_TYPE="ssd"
  fi

  echo "[*] Hardware: RAM=${MEM_MB}MB CPU=${CPU_CORES} DISK=${DISK_TYPE}"
}
