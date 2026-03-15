# Chinese Commit Hook Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add a repository-shared Git commit hook that requires a Chinese summary in normal commit messages.

**Architecture:** Keep all tracked changes in the isolated `codex/chinese-commit-hook` worktree. Add a versioned hook under `.githooks/`, add a small PowerShell verification script that exercises the hook in red-green style, and add a short repository doc explaining setup and behavior. Apply `core.hooksPath` locally for this repository after the tracked files are in place.

**Tech Stack:** Git hooks, POSIX shell for the hook, PowerShell for local verification

---

### Task 1: Add the failing verification script first

**Files:**
- Create: `scripts/test-commit-msg-hook.ps1`
- Reference: `docs/plans/2026-03-15-chinese-commit-hook-design.md`

**Step 1: Write the failing test script**

Create `scripts/test-commit-msg-hook.ps1` that:
- Locates `.githooks/commit-msg` relative to the repository root
- Exits non-zero if the hook file does not exist
- Writes temporary commit message files for:
  - `docs: add hook`
  - `docs: <Chinese summary>`
  - `Merge branch 'x'`
- Invokes the hook script against each message file
- Expects:
  - English summary is rejected
  - Chinese summary is accepted
  - Merge message is accepted
- Prints a short pass/fail line for each case

**Step 2: Run the script to verify RED**

Run: `powershell -ExecutionPolicy Bypass -File scripts/test-commit-msg-hook.ps1`
Expected: FAIL because `.githooks/commit-msg` does not exist yet.

### Task 2: Implement the hook

**Files:**
- Create: `.githooks/commit-msg`
- Test: `scripts/test-commit-msg-hook.ps1`

**Step 1: Write the hook**

Create `.githooks/commit-msg` as a POSIX shell script that:
- Reads the first line from the commit message file
- Allows messages starting with `Merge `, `Revert `, `fixup! `, or `squash! `
- Splits on the first `:`
- Treats the text after the first colon as the summary
- Rejects the message if that summary does not contain at least one CJK Unified Ideograph codepoint
- Prints a short Chinese-facing rejection message and exits non-zero on failure

**Step 2: Re-run the script to verify GREEN**

Run: `powershell -ExecutionPolicy Bypass -File scripts/test-commit-msg-hook.ps1`
Expected: PASS for all scripted checks.

### Task 3: Document and enable the hook

**Files:**
- Create: `docs/git-hooks.md`
- Modify: `.git/config` (local repository config only, not tracked)
- Verify: `.githooks/commit-msg`

**Step 1: Document the behavior**

Create `docs/git-hooks.md` with:
- What the commit hook enforces
- Accepted examples
- Rejected examples
- How to enable hooks with `git config core.hooksPath .githooks`
- A note that `core.hooksPath` is local to each clone

**Step 2: Enable the hook in this local repository**

Run: `git config core.hooksPath .githooks`
Expected: `git config --get core.hooksPath` returns `.githooks`

**Step 3: Verify real Git integration in a temporary repository**

Run a PowerShell verification flow that:
- Creates a temporary Git repository
- Copies `.githooks/commit-msg` into that repository
- Sets `core.hooksPath` to `.githooks`
- Attempts `git commit --allow-empty -F <english-message-file>` and expects failure
- Attempts `git commit --allow-empty -F <chinese-message-file>` and expects success

Expected: the real Git commit flow matches the direct script checks.

### Task 4: Final verification and commit

**Files:**
- Verify: `.githooks/commit-msg`
- Verify: `scripts/test-commit-msg-hook.ps1`
- Verify: `docs/git-hooks.md`
- Verify: `docs/plans/2026-03-15-chinese-commit-hook-design.md`
- Verify: `docs/plans/2026-03-15-chinese-commit-hook-plan.md`

**Step 1: Check tracked changes**

Run: `git status --short`
Expected: only the new hook, test script, docs, and plan files are changed in the worktree.

**Step 2: Re-run verification**

Run: `powershell -ExecutionPolicy Bypass -File scripts/test-commit-msg-hook.ps1`
Run: `git config --get core.hooksPath`
Expected: tests pass and hooksPath is `.githooks`

**Step 3: Commit**

Run: `git add .githooks/commit-msg scripts/test-commit-msg-hook.ps1 docs/git-hooks.md docs/plans/2026-03-15-chinese-commit-hook-design.md docs/plans/2026-03-15-chinese-commit-hook-plan.md`
Run: `git commit -m "chore: <Chinese summary>"`
Expected: commit succeeds with the hook, docs, and verification script.
