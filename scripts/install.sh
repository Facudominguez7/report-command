#!/usr/bin/env bash
set -euo pipefail

REPO_SSH="${REPO_SSH:-git@github.com:relexsrl/notion-report-command.git}"
DESTINO="${NOTION_REPORT_HOME:-$HOME/.relex/notion-report-command}"

crear_checkout() {
  mkdir -p "$(dirname "$DESTINO")"
  if [ -d "$DESTINO/.git" ]; then
    git -C "$DESTINO" fetch --all --prune
    git -C "$DESTINO" pull --ff-only
  else
    git clone "$REPO_SSH" "$DESTINO"
  fi
}

main() {
  command -v git >/dev/null 2>&1 || { printf 'Falta git en el sistema.\n' >&2; exit 1; }
  crear_checkout
  bash "$DESTINO/scripts/sync.sh"
  printf 'notion-report-command instalado en %s\n' "$DESTINO"
}

main "$@"
