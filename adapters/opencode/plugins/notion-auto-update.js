import { spawn } from "node:child_process"
import { existsSync } from "node:fs"
import path from "node:path"
import os from "node:os"

/**
 * Dispara una actualización silenciosa del repositorio al iniciar una sesión.
 */
export const NotionAutoUpdatePlugin = async ({ client }) => {
  const directorioInstalacion = process.env.NOTION_REPORT_HOME || path.join(os.homedir(), ".relex", "notion-report-command")
  const scriptActualizacion = path.join(directorioInstalacion, "scripts", process.platform === "win32" ? "update.ps1" : "update.sh")

  const ejecutarActualizacion = async () => {
    if (!existsSync(scriptActualizacion)) {
      return
    }

    if (process.platform === "win32") {
      spawn("powershell", ["-ExecutionPolicy", "Bypass", "-File", scriptActualizacion, "-Silent"], {
        detached: true,
        stdio: "ignore",
      }).unref()
      return
    }

    spawn("bash", [scriptActualizacion, "--silent"], {
      detached: true,
      stdio: "ignore",
    }).unref()
  }

  return {
    "session.created": async () => {
      await ejecutarActualizacion()
      if (client?.app?.log) {
        await client.app.log({
          body: {
            service: "notion-report-command",
            level: "info",
            message: "Chequeo silencioso de actualización lanzado",
          },
        })
      }
    },
  }
}
