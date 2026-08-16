// tmux toasts, ported from the Claude Code Notification and Stop hooks.
//
//   Claude Stop         -> opencode session.idle
//   Claude Notification -> opencode permission.ask
//
// permission.ask receives an output object whose status decides the permission.
// We only read it, never write, so the prompt behaves exactly as it would
// without this plugin.

export const TmuxNudge = async ({ $ }) => {
  const toast = async (message, ms) => {
    if (!process.env.TMUX) return
    try {
      await $`tmux display-message -d ${ms} ${message}`.quiet()
    } catch {
      // no tmux server, or the pane went away — never break the session
    }
  }

  return {
    event: async ({ event }) => {
      if (event?.type === "session.idle") await toast("opencode: done", 3000)
    },

    "permission.ask": async () => {
      await toast("opencode: needs your input", 5000)
    },
  }
}
