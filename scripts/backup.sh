#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  printf 'Usage: %s SOURCE BACKUP_DIR [RETENTION_DAYS]\n' "$0" >&2
}

if (( $# < 2 || $# > 3 )); then
  usage
  exit 2
fi

readonly SOURCE="$1"
readonly BACKUP_DIR="$2"
readonly RETENTION_DAYS="${3:-7}"
TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
readonly TIMESTAMP
readonly LOG_FILE="${BACKUP_DIR}/backup.log"

if [[ ! -d "$SOURCE" ]]; then
  printf 'Source is not a directory: %s\n' "$SOURCE" >&2
  exit 1
fi
if [[ ! "$RETENTION_DAYS" =~ ^[0-9]+$ ]]; then
  printf 'Retention must be a non-negative integer\n' >&2
  exit 2
fi

mkdir -p "$BACKUP_DIR"
readonly ARCHIVE="${BACKUP_DIR}/backup-${TIMESTAMP}.tar.gz"

on_error() {
  local exit_code=$?
  printf '%s status=failed exit_code=%d archive=%s\n' \
    "$(date --iso-8601=seconds)" "$exit_code" "$ARCHIVE" >>"$LOG_FILE"
  exit "$exit_code"
}
trap on_error ERR

tar --create --gzip --file "$ARCHIVE" --directory "$(dirname "$SOURCE")" \
  "$(basename "$SOURCE")"
tar --test-label --file "$ARCHIVE" >/dev/null
find "$BACKUP_DIR" -maxdepth 1 -type f -name 'backup-*.tar.gz' \
  -mtime "+${RETENTION_DAYS}" -delete
printf '%s status=success archive=%s\n' \
  "$(date --iso-8601=seconds)" "$ARCHIVE" >>"$LOG_FILE"
printf '%s\n' "$ARCHIVE"
