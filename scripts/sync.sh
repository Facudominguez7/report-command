#!/usr/bin/env bash
set -euo pipefail

RAIZ="${REPORT_COMMAND_HOME:-${NOTION_REPORT_HOME:-$HOME/.rajadeacarubio/report-command}}"

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

limpiar_obsoletos() {
  echo "Limpiando archivos obsoletos de versiones anteriores..."
  # Comandos viejos (notion.md en lugar de report.md)
  rm -f "$HOME/.claude/commands/notion.md"
  rm -f "$HOME/.config/opencode/commands/notion.md"
  # Skills viejas (nombres anteriores a internal-weekly-report)
  rm -rf "$HOME/.claude/skills/report-weekly-report/"
  rm -rf "$HOME/.config/opencode/skills/report-weekly-report/"
  rm -rf "$HOME/.config/opencode/skills/notion-weekly-report/"
  # OpenCode ya no instala la skill internal-weekly-report (solo /report)
  rm -rf "$HOME/.config/opencode/skills/internal-weekly-report/"
  echo "Limpieza completada."
}

main() {
  limpiar_obsoletos
  crear_link_o_copia "$RAIZ/adapters/claude/commands/report.md" "$HOME/.claude/commands/report.md"
  crear_link_o_copia "$RAIZ/shared/skills/internal-weekly-report/SKILL.md" "$HOME/.claude/skills/internal-weekly-report/SKILL.md"
  crear_link_o_copia "$RAIZ/adapters/opencode/commands/report.md" "$HOME/.config/opencode/commands/report.md"
  crear_link_o_copia "$RAIZ/adapters/opencode/plugins/report-auto-update.js" "$HOME/.config/opencode/plugins/report-auto-update.js"
}

main "$@"
