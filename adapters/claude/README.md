# Adaptador Claude Code

Este directorio contiene los archivos que deben exponerse en `~/.claude/` para que el comando `/notion` funcione en Claude Code.

## Archivos relevantes

- `commands/notion.md` — comando visible como `/notion`
- `settings.local.fragment.json` — fragmento base para registrar el hook de auto-update

## Nota

La integración final del hook debe hacerse fusionando el fragmento en `~/.claude/settings.local.json` o `~/.claude/settings.json` sin romper configuración existente.
