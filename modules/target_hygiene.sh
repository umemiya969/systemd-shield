#!/usr/bin/env bash
# systemd-shield - target_hygiene
# Purpose:
# - Clean unnecessary target wants
# - Reduce startup noise
# - Preserve systemd dependency graph integrity
# - Support sysinit-like minimalism safely

apply_target_hygiene() {

  # Targets that must NEVER be touched
  PROTECTED_TARGETS=(
    basic.target
    sysinit.target
    network.target
    network-online.target
    multi-user.target
    graphical.target
    rescue.target
    emergency.target
  )

  # Targets allowed for hygiene cleanup
  CLEANABLE_TARGETS=(
    printer.target
    bluetooth.target
    sound.target
    smartcard.target
  )

  for target in "${CLEANABLE_TARGETS[@]}"; do

    # Skip protected targets explicitly
    for protected in "${PROTECTED_TARGETS[@]}"; do
      [[ "$target" == "$protected" ]] && continue 2
    done

    wants_dir="/etc/systemd/system/${target}.wants"

    # Only operate on override directory
    if [[ ! -d "$wants_dir" ]]; then
      echo "[target_hygiene] No overrides for $target"
      continue
    fi

    echo "[target_hygiene] Cleaning wants for $target"

    for link in "$wants_dir"/*.service "$wants_dir"/*.socket; do
      [[ -e "$link" ]] || continue

      echo "[target_hygiene] Removing override: $(basename "$link")"
      rm -f "$link"
    done
  done
}
