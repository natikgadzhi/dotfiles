## VibeTunnel Terminal Title Management

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

# Project Rules
@/Users/natikgadzhi/src/steipete/agent-rules/project-rules
