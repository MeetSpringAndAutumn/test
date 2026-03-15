# Superpowers Subagent Demo Overview

This directory records two related demos from one Codex session.

## Stage 1: Pseudo-parallel workflow

Files in this stage:
- `docs/demo-parallel-task-1.md`
- `docs/demo-parallel-task-2.md`
- `docs/plans/2026-03-15-superpowers-parallel-demo-design.md`
- `docs/plans/2026-03-15-superpowers-parallel-demo-plan.md`

What this stage proves:
- Skill selection and sequencing can be applied in this repository session.
- An isolated worktree can be used to protect the dirty main workspace.
- Independent checks and supporting actions can be run with parallel main-session tool calls.

What this stage does not prove by itself:
- True spawned-subagent support. Stage 1 intentionally used only main-session tool calls, so it left real subagent support unverified at that point.

## Stage 2: Real parallel subagent write

Files in this stage:
- `docs/demo-real-subagent-write-1.md`
- `docs/demo-real-subagent-write-2.md`
- `docs/plans/2026-03-15-real-parallel-subagent-write-design.md`
- `docs/plans/2026-03-15-real-parallel-subagent-write-demo-plan.md`

What this stage proves:
- This Codex environment can dispatch true spawned subagents.
- Two real subagents can be started in parallel.
- Two real subagents can write to separate files without conflicts when their write scopes are disjoint.

## Final conclusion

The final conclusion from the two-stage sequence is that this environment does support true spawned subagents. Stage 1 did not disprove that capability; it simply did not exercise it yet.

## Session-specific values

Absolute paths, branch names, and worktree names shown in these files are example values recorded from this repository session. They are evidence from this run, not defaults that other repositories must copy.
