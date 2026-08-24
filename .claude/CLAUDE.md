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

## Where session data lives

- **Raw transcripts** (Claude Code's own, JSONL): `~/.claude/projects/<slugified-cwd>/<session-id>.jsonl`.
- **Generated markdown summaries**: `~/.local/share/claude-sessions/`, named `{date}-{project}-{short-id}.md`.
  Produced by the `SessionEnd` hook `~/src/natikgadzhi/scripts/claude-session-export.py`; `obsidian-tools`
  then syncs them into the Obsidian vault.

# Personal profile

@~/.claude/profile.local.md

# Writing style

@~/.claude/writing-style.local.md
