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

  lsblk -d -o rota | grep -q 1 && DISK_TYPE="hdd" || DISK_TYPE="ssd"

  export MEM_MB CPU_CORES HW_PROFILE DISK_TYPE
  echo "[HW] $HW_PROFILE | RAM=${MEM_MB}MB | CPU=$CPU_CORES | $DISK_TYPE"
}
