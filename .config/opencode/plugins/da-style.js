// Re-inject the DA writing-style rules on every turn.
//
// Claude Code does this with a UserPromptSubmit hook that appends
// .claude/style-reminder.md as additionalContext. opencode has no
// UserPromptSubmit, but chat.message hands us the outgoing user message with a
// mutable parts array, which is the same injection point by another name.
//
// Appends to the last text part rather than pushing a new one, so we never have
// to construct a Part and guess at its required fields.

import { readFile } from "node:fs/promises"
import { join } from "node:path"

const REMINDER = ".claude/style-reminder.md"

export const DaStyle = async ({ directory, worktree }) => {
  const root = worktree || directory

  return {
    "chat.message": async (_input, output) => {
      if (!root.includes("/src/da")) return

      let rules
      try {
        rules = (await readFile(join(root, REMINDER), "utf8")).trim()
      } catch {
        return // no reminder file here; stay out of the way
      }
      if (!rules) return

      const parts = output?.parts
      if (!Array.isArray(parts)) return

      for (let i = parts.length - 1; i >= 0; i--) {
        const part = parts[i]
        if (part?.type === "text" && typeof part.text === "string") {
          part.text += `\n\n<style-reminder>\n${rules}\n</style-reminder>`
          return
        }
      }
    },
  }
}
