#!/usr/bin/env bash
set -Eeuo pipefail

readonly OUTPUT="${1:-/dev/stdout}"

{
  printf 'generated_at=%s\n' "$(date --iso-8601=seconds)"
  printf 'hostname=%s\n' "$(hostname)"
  printf 'kernel=%s\n' "$(uname -r)"
  printf 'uptime_seconds=%s\n' "$(cut -d' ' -f1 /proc/uptime)"
  printf 'cpu_count=%s\n' "$(getconf _NPROCESSORS_ONLN)"
  awk '/MemTotal|MemAvailable/ {printf "%s_kb=%s\n", tolower($1), $2}' /proc/meminfo
  df --output=source,pcent,avail,target -x tmpfs -x devtmpfs
} >"$OUTPUT"
