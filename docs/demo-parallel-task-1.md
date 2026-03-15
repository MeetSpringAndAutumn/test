# Demo Task 1: Workspace Verification

> This file belongs to stage 1 of the recorded demo sequence. See `docs/superpowers-subagent-demo-overview.md` for the relationship between the pseudo-parallel and real-subagent demos.

## Purpose

This task verifies that the stage 1 demo is running inside an isolated Git worktree on the intended branch, without interfering with the dirty main workspace.

## Inputs

- Example repository root from this session: `D:\Project\test`
- Example worktree path from this session: `D:\Project\test\.worktrees\superpowers-parallel-demo`
- Example branch from this session: `codex/superpowers-parallel-demo`
- Note: these values are session-specific examples, not required defaults.

## Checklist

- Verify the current branch inside the worktree is `codex/superpowers-parallel-demo`
- Verify the isolated worktree path exists and is separate from the main workspace root
- Verify the demo worktree status is clean after the planned commits are created

## Expected Evidence

- `git -C .worktrees/superpowers-parallel-demo branch --show-current`
- `git -C .worktrees/superpowers-parallel-demo rev-parse --show-toplevel`
- `git -C .worktrees/superpowers-parallel-demo status --short`
