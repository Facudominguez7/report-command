#!/usr/bin/env bash
set -euo pipefail

SILENCIOSO="false"
if [ "${1:-}" = "--silent" ]; then
  SILENCIOSO="true"
fi

DESTINO="${NOTION_REPORT_HOME:-$HOME/.relex/notion-report-command}"

registrar() {
  if [ "$SILENCIOSO" != "true" ]; then
    printf '%s\n' "$1"
  fi
}

main() {
  [ -d "$DESTINO/.git" ] || exit 0
  git -C "$DESTINO" fetch --all --prune >/dev/null 2>&1 || exit 0
  git -C "$DESTINO" pull --ff-only >/dev/null 2>&1 || exit 0
  bash "$DESTINO/scripts/sync.sh" >/dev/null 2>&1 || true
  registrar "notion-report-command actualizado"
}

main "$@"
