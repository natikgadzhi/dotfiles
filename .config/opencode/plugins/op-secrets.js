// Resolve 1Password secret references in MCP config at startup.
//
// Pattern: {op:op://vault/item/field} → resolved value via `op read`
// Applied to: mcp[*].headers, mcp[*].environment, mcp[*].command (array)
//
// Prerequisite: `op signin` must be done once per machine (keychain stores the session).
// This plugin runs in the `config` hook, before MCP servers connect.

import { spawnSync } from "node:child_process";

const OP_PATTERN = /\{op:([^}]+)\}/g;

function resolve(value) {
  if (typeof value !== "string") return value;
  return value.replace(OP_PATTERN, (_match, ref) => {
    const result = spawnSync("op", ["read", "--account", "lambdalabs.1password.com", ref], {
      encoding: "utf8",
      timeout: 10000,
    });
    if (result.status !== 0) {
      throw new Error(`op read ${ref} failed: ${result.stderr || "unknown error"}`);
    }
    return result.stdout.trim();
  });
}

export default async () => ({
  config: (cfg) => {
    for (const server of Object.values(cfg.mcp ?? {})) {
      if (server.headers) {
        for (const key of Object.keys(server.headers)) {
          server.headers[key] = resolve(server.headers[key]);
        }
      }
      if (server.environment) {
        for (const key of Object.keys(server.environment)) {
          server.environment[key] = resolve(server.environment[key]);
        }
      }
      if (Array.isArray(server.command)) {
        server.command = server.command.map(resolve);
      }
    }
  },
});
