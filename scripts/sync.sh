#!/usr/bin/env bash
set -euo pipefail

RAIZ="${REPORT_COMMAND_HOME:-${NOTION_REPORT_HOME:-$HOME/.relex/report-command}}"

crear_link_o_copia() {
  origen="$1"
  destino="$2"
  mkdir -p "$(dirname "$destino")"
  rm -f "$destino"
  if ln -s "$origen" "$destino" 2>/dev/null; then
    return 0
  fi
  cp "$origen" "$destino"
}

main() {
  crear_link_o_copia "$RAIZ/adapters/claude/commands/report.md" "$HOME/.claude/commands/report.md"
  crear_link_o_copia "$RAIZ/shared/skills/report-weekly-report/SKILL.md" "$HOME/.claude/skills/report-weekly-report/SKILL.md"
  crear_link_o_copia "$RAIZ/adapters/opencode/commands/report.md" "$HOME/.config/opencode/commands/report.md"
  crear_link_o_copia "$RAIZ/shared/skills/report-weekly-report/SKILL.md" "$HOME/.config/opencode/skills/report-weekly-report/SKILL.md"
  crear_link_o_copia "$RAIZ/adapters/opencode/plugins/report-auto-update.js" "$HOME/.config/opencode/plugins/report-auto-update.js"
}

main "$@"
