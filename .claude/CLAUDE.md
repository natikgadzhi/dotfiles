# Natik's CLAUDE.md

This file contains a set of rules for Claude and other agents to follow.

## Machines

This CLAUDE.md and rules are shared between Natik's personal machine, homelab, and work machine.
- Consider all machines running MacOS that are otherwise not described personal IF the username is `natikgadzhi`.
- Work machine is defined as the machine with hostname `A02559`. Username on the work machine is  `natik.gadzhi`, different from the personal machine. This machine has stricter firewall rules and some utilities and rules are not available.

## VibeTunnel Terminal Title Management

**Note**: VibeTunnel is not available on Lambda work machine, do not use it there.

When working in VibeTunnel sessions, actively use the `vt title` command to communicate actions and progress:

### Usage
vt title "Current action - project context"

### Guidelines
- Update frequently
- Be descriptive
- Include context
- Think of it as a status indicator
- Ignore errors if `vt` command fails

### Examples

```
  # Starting a task
  vt title "Setting up Git app integration"

  # Debugging
  vt title "Debugging CI failures - playwright tests"

  # Working on a PR
  vt title "Implementing unique session names - github.com/amantus-ai/vibetunnel/pull/456"

  # Analyzing code
  vt title "Analyzing session-manager.ts for race conditions"

  # Writing tests
  vt title "Adding tests for GitAppLauncher"
```

### When to Update
- Start of each new task/subtask
- Switching between files/modules
- Changing from coding to testing/debugging
- Waiting for long-running operations
- Whenever user might wonder "what is Claude doing right now?"

## Git Workflow Notes

- All worktrees should be in `~/src/worktrees/`.
- IF you are invoked within a worktree, but the project root directory appears to be empty and not a git repository, it's likely that something else deleted that worktree. When this happens, do NOT attempt to generate the project or task files from scratch. Tell the user that the worktree likely has been removed and ask what to do next.
- Available commands:
  @~/.claude/create-worktree.md

**Note**: GitHub automatically deletes remote branches after PR merges (when configured). Do not manually delete remote branches with `git push origin --delete`.

## Project Rules
@/Users/natikgadzhi/src/steipete/agent-rules/project-rules
