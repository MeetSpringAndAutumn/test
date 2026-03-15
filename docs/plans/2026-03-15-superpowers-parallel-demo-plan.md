# Superpowers Parallel Demo Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create a minimal, verifiable stage 1 demo that shows how superpowers can structure a Codex workflow that resembles subagent usage.

**Architecture:** Keep all implementation inside the isolated `codex/superpowers-parallel-demo` worktree. Add two independent Markdown task files that represent parallel pseudo-agent scopes, then run the supporting checks in parallel and synthesize the result in the final response. This plan intentionally limits stage 1 to main-session parallel tool calls, leaving true spawned-subagent verification to a later follow-up.

**Tech Stack:** Markdown, Git worktree workflow, Codex parallel tool calls

**Context:** This plan records only stage 1 of the sequence described in `docs/superpowers-subagent-demo-overview.md`. The branch and worktree values in this plan are example values from this session, not defaults for every repository.

---

### Task 1: Create the workspace-verification demo task

**Files:**
- Create: `docs/demo-parallel-task-1.md`
- Reference: `docs/plans/2026-03-15-superpowers-parallel-demo-design.md`

**Step 1: Review the approved design**

Read: `docs/plans/2026-03-15-superpowers-parallel-demo-design.md`
Expected: The file confirms the demo is limited to two new Markdown artifacts and final-response synthesis.

**Step 2: Draft the task document**

Write `docs/demo-parallel-task-1.md` with these sections:
- Title: `# Demo Task 1: Workspace Verification`
- Purpose: explain that this task checks branch, worktree isolation, and clean status inside the demo workspace
- Inputs: repository path and worktree branch name
- Checklist: verify current branch, verify isolated worktree path, verify clean status in the worktree
- Expected evidence: short bullet list of commands that prove those checks

**Step 3: Verify the file exists and is readable**

Run: `Get-Content docs/demo-parallel-task-1.md`
Expected: The full Markdown document prints without errors.

**Step 4: Commit the task file**

Run: `git add docs/demo-parallel-task-1.md`
Run: `git commit -m "docs: add workspace verification demo task"`
Expected: Commit succeeds with one new file.

### Task 2: Create the runtime-capability demo task

**Files:**
- Create: `docs/demo-parallel-task-2.md`
- Reference: `docs/plans/2026-03-15-superpowers-parallel-demo-design.md`

**Step 1: Review the approved design**

Read: `docs/plans/2026-03-15-superpowers-parallel-demo-design.md`
Expected: The file confirms the demo must not overclaim true spawned-subagent support in stage 1.

**Step 2: Draft the task document**

Write `docs/demo-parallel-task-2.md` with these sections:
- Title: `# Demo Task 2: Runtime Capability Audit`
- Purpose: explain that this task checks what stage 1 can verify directly and what remains unverified until the follow-up
- Inputs: loaded skills and available tool families used in stage 1
- Checklist: confirm skill selection works, confirm parallel tool calls work, confirm stage 1 does not exercise true spawned-subagent dispatch
- Expected evidence: short bullet list of commands or observations that support those conclusions

**Step 3: Verify the file exists and is readable**

Run: `Get-Content docs/demo-parallel-task-2.md`
Expected: The full Markdown document prints without errors.

**Step 4: Commit the task file**

Run: `git add docs/demo-parallel-task-2.md`
Run: `git commit -m "docs: add runtime capability demo task"`
Expected: Commit succeeds with one new file.

### Task 3: Execute the pseudo-parallel demo and verify outputs

**Files:**
- Verify: `docs/demo-parallel-task-1.md`
- Verify: `docs/demo-parallel-task-2.md`
- Verify: `docs/plans/2026-03-15-superpowers-parallel-demo-design.md`
- Verify: `docs/plans/2026-03-15-superpowers-parallel-demo-plan.md`

**Step 1: Run the workspace checks**

Run: `git branch --show-current`
Run: `git status --short`
Expected: Branch is `codex/superpowers-parallel-demo` and status shows only the planned demo files before commit, then a clean tree after commit.

**Step 2: Run the runtime checks**

Run: read the two task files and inspect the currently available tool families used in stage 1.
Expected: Evidence supports that parallel operations are available, while true spawned-subagent support remains unverified in this phase because stage 1 does not use it.

**Step 3: Run the two verification tracks in parallel**

Run the workspace verification checks and runtime capability checks concurrently.
Expected: Both tracks complete independently without touching the same files.

**Step 4: Prepare the final synthesis**

Summarize:
- what parts of the superpowers workflow were exercised successfully
- what remained unverified at the end of stage 1
- what fresh verification evidence supports the summary

**Step 5: Final verification**

Run: `git status --short`
Expected: No unexpected modifications remain in the demo worktree.

