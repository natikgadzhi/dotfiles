<!--
User-level Claude Code memory. Loaded in EVERY project on this machine.
~/.claude/CLAUDE.md is a symlink to this file (dotfiles — PUBLIC repo).

KEEP THIS FILE PII-FREE. The personal profile is imported below from
~/.claude/profile.local.md, a machine-local symlink to the private Obsidian note
("Claude Profile Prompt.md"). That target is outside this repo, so nothing personal
is published. The import path has no spaces on purpose — Claude's @import parser
stops at whitespace, so the indirection through a no-space symlink is deliberate.

New machine: clone dotfiles, point ~/.claude/CLAUDE.md at this file, then:
    ln -sfn "$HOME/Documents/Obsidian/Personal/Claude Profile Prompt.md" "$HOME/.claude/profile.local.md"
    ln -sfn "$HOME/Documents/Obsidian/Personal/Claude Writing Style.md" "$HOME/.claude/writing-style.local.md"
(adjust the note paths if the vault lives elsewhere on that machine).

opencode consumes the same two symlinks via `instructions` in
~/.config/opencode/opencode.json (it doesn't follow Claude's @import syntax,
so the files are listed there directly). Missing files are tolerated, so
machines without the vault still start fine.
-->

# Claude Code — CLI-specific notes

<!-- Guidance specific to the Claude Code CLI (and not in the general profile) goes here. -->

## Datadog queries (Pup CLI)

Use the Pup CLI (`pup`) for Datadog lookups from any agent. Always `--read-only`.
Auth is OAuth via `pup auth login`; if OAuth is ever disabled on the org, fall back
to a 1Password-stored API key resolved with `op read 'op://...'`.

- Skills auto-installed under `~/.claude/skills/dd-*` by `pup skills install claude`.
- APM endpoint/traffic questions: `pup apm services`, `pup traces metrics`, `pup traces search`.
- Before deleting a backend endpoint/route (e.g. "dead code from LL"), confirm zero traffic in Datadog with `pup` first.

## Secrets (1Password)

1Password secrets are referenced as `op://vault/item/field` and resolved via the
`op` CLI (`op read 'op://...'`). Never print resolved secret values into output
or logs; never commit them.

- `op whoami` must return signed-in before any `op read`. Re-sign with
  `op signin lambdalabs.1password.com` if needed.
- MCP headers in `~/src/lambdal/.mcp.json` that need 1Password secrets use
  the `headersHelper` script at `~/src/natikgadzhi/scripts/op-mcp-bearer-header.sh`.

## Where session data lives

- **Raw transcripts** (Claude Code's own, JSONL): `~/.claude/projects/<slugified-cwd>/<session-id>.jsonl`.
- **Generated markdown summaries**: `~/.local/share/claude-sessions/`, named `{date}-{project}-{short-id}.md`.
  Produced by the `SessionEnd` hook `~/src/natikgadzhi/scripts/claude-session-export.py`; `obsidian-tools`
  then syncs them into the Obsidian vault.

# Personal profile

@~/.claude/profile.local.md

# Writing style

@~/.claude/writing-style.local.md
