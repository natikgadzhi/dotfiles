// Ensure Pup CLI runs inside opencode's bash tool produce structured
// agent-mode output (JSON, metadata envelope, auto-approved confirms).
//
// Pup auto-detects Claude Code, Pi, Codex, etc. via well-known env vars
// (see `pup --help`), but opencode isn't on the list yet. `OPENCODE=1`
// is set by opencode itself and Pup currently honours it, but that's
// undocumented — `FORCE_AGENT_MODE=1` is the supported override.
//
// The `shell.env` hook mutates the environment passed to every bash
// tool invocation, so `FORCE_AGENT_MODE=1` lands in every shell opencode
// spawns without touching the user's shell rc.

export default async () => ({
  "shell.env": async (_input, output) => {
    output.env.FORCE_AGENT_MODE = "1";
  },
});
