# Adaptador OpenCode

Este directorio contiene los archivos que deben exponerse en `~/.config/opencode/` para que `/report` funcione en OpenCode.

## Archivos relevantes

- `commands/report.md` — comando visible como `/report`
- `plugins/report-auto-update.js` — plugin base para disparar auto-update al inicio

## Nota

El plugin actual es una base funcional mínima y debe validarse en entorno real contra la versión exacta de OpenCode usada por el equipo.
