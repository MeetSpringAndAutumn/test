# Demo Task 1: Workspace Verification

## Purpose

This task verifies that the demo is running inside an isolated Git worktree on the intended branch, without interfering with the dirty main workspace.

## Inputs

- Repository root: `D:\Project\test`
- Worktree path: `D:\Project\test\.worktrees\superpowers-parallel-demo`
- Expected branch: `codex/superpowers-parallel-demo`

## Checklist

- Verify the current branch inside the worktree is `codex/superpowers-parallel-demo`
- Verify the isolated worktree path exists and is separate from the main workspace root
- Verify the demo worktree status is clean after the planned commits are created

## Expected Evidence

- `git -C .worktrees/superpowers-parallel-demo branch --show-current`
- `git -C .worktrees/superpowers-parallel-demo rev-parse --show-toplevel`
- `git -C .worktrees/superpowers-parallel-demo status --short`

