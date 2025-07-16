# Create Worktree Instructions

## Usage
This instruction file is for creating git worktrees for todos. Use it as a slash command:

```
/create-worktree <todo-name>
```

## Steps to Create Worktree

### 1. Determine Repository Information
- Get current working directory path
- Extract organization name and repo name from path (format: `~/src/{org}/{repo}`). You may be running in core repo, or within a worktree already. Worktrees are in `~/src/worktrees/{org}/{repo}`.
- Get current git remote URL to confirm organization/repo names.

### 2. Get Current User
```bash
git config user.name
```


### 3. Create Worktree Directory Structure
```bash
mkdir -p ~/src/worktrees/{organization}/{repo-name}
```

### 4. Create New Branch
Branch naming convention: `{username}/{todo-name}`
```bash
git worktree add ~/src/worktrees/{organization}/{repo-name}/{todo-name} -b {username}/{todo-name}
```

### 5. Switch to Worktree
```bash
cd ~/src/worktrees/{organization}/{repo-name}/{todo-name}
```

Check if the repo the user was in has `.claude/todos/` directory. If so, check if it has a file that matches your todo name. If you are not sure or the match is partial, ask the user if they want to work on that todo. If the todo file does NOT exist, warn the user, ask if they want to proceed and create the worktree still.

### 6. Verify Setup
```bash
git status
git branch
pwd
```

## Example
For todo `2025-01-16-frontend-renaming-plan` in `lambdal/lambda-chat-backend`:
```bash
# User: natikgadzhi
# Organization: lambdal
# Repo: lambda-chat-backend
# Todo: 2025-01-16-frontend-renaming-plan

mkdir -p ~/src/worktrees/lambdal/lambda-chat-backend
git worktree add ~/src/worktrees/lambdal/lambda-chat-backend/2025-01-16-frontend-renaming-plan -b natik.gadzhi/2025-01-16-frontend-renaming-plan
cd ~/src/worktrees/lambdal/lambda-chat-backend/2025-01-16-frontend-renaming-plan
```

## Cleanup After Work
When todo is complete:
1. Commit all changes
2. Ask user if they want to push to remote
3. If yes, push branch
4. Switch back to main repo
Verify that the user wants to delete the worktree or keep it.
5. Delete worktree:
```bash
git worktree remove ~/src/worktrees/{organization}/{repo-name}/{todo-name}
```

## Notes
- Worktree name should match the todo file name
- Branch names are prefixed with username
- All worktrees go in `~/src/worktrees/{org}/{repo}/{todo-name}`
- Original repo stays in `~/src/{org}/{repo}`