#!/usr/bin/env bash
set -euo pipefail

RAIZ="${NOTION_REPORT_HOME:-$HOME/.relex/notion-report-command}"

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
  crear_link_o_copia "$RAIZ/adapters/claude/commands/notion.md" "$HOME/.claude/commands/notion.md"
  crear_link_o_copia "$RAIZ/shared/skills/notion-weekly-report/SKILL.md" "$HOME/.claude/skills/notion-weekly-report/SKILL.md"
  crear_link_o_copia "$RAIZ/adapters/opencode/commands/notion.md" "$HOME/.config/opencode/commands/notion.md"
  crear_link_o_copia "$RAIZ/shared/skills/notion-weekly-report/SKILL.md" "$HOME/.config/opencode/skills/notion-weekly-report/SKILL.md"
  crear_link_o_copia "$RAIZ/adapters/opencode/plugins/notion-auto-update.js" "$HOME/.config/opencode/plugins/notion-auto-update.js"
}

main "$@"
