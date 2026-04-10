#!/usr/bin/env bash
set -euo pipefail

RAIZ_SCRIPT="$(dirname "$(realpath "$0")")"
RAIZ_REPO="$(realpath "$RAIZ_SCRIPT/..")"

main() {
  mkdir -p "$RAIZ_REPO/reportes"
  NOTION_REPORT_HOME="$RAIZ_REPO" bash "$RAIZ_REPO/scripts/sync.sh"
  printf 'report-command enlazado desde checkout local en %s\n' "$RAIZ_REPO"
}

main "$@"
