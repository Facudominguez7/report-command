# Instalación de `report-command`

## Opción 1 — Desde repositorio publicado

Usar esta opción cuando `report-command` ya esté publicado como repositorio propio en GitHub.

### Linux

```bash
curl -fsSL https://raw.githubusercontent.com/Facudominguez7/report-command/main/scripts/install.sh | bash
```

### Windows

```powershell
irm https://raw.githubusercontent.com/Facudominguez7/report-command/main/scripts/install.ps1 | iex
```

Notas:

- Requiere `git`.
- Instala el checkout administrado en `~/.relex/report-command`.

## Opción 2 — Desde checkout local

Usar esta opción mientras la herramienta todavía vive dentro de otro repositorio o antes de publicarla en GitHub como repo independiente.

### Linux

Parado dentro de `report-command/`:

```bash
bash scripts/install-local.sh
```

### Windows

Parado dentro de `report-command/`:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-local.ps1
```

Qué hace:

- usa el checkout local actual como `NOTION_REPORT_HOME`,
- sincroniza el comando `/report` en Claude Code y OpenCode,
- deja preparada la carpeta `reportes/` para el fallback Markdown.

## Qué se instala

### Claude Code

- `~/.claude/commands/report.md`
- `~/.claude/skills/internal-weekly-report/SKILL.md`

### OpenCode

- `~/.config/opencode/commands/report.md`
- `~/.config/opencode/skills/internal-weekly-report/SKILL.md`
- `~/.config/opencode/plugins/report-auto-update.js`

## Verificación rápida

Después de instalar:

1. Abrí Claude Code u OpenCode.
2. Ejecutá `/report`.
3. Si Notion está configurado, debe usar la página semanal.
4. Si Notion no está configurado, debe usar fallback local en:

```text
reportes/semana-YYYY-MM-DD_a_YYYY-MM-DD/
```

## Estado actual

Si todavía no se publicó a GitHub, usá la **Opción 2 — Desde checkout local**.
