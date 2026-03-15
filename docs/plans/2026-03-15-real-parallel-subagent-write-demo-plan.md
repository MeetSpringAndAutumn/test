# Real Parallel Subagent Write Demo Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Demonstrate true parallel subagent writes by having two real subagents create two separate Markdown files in the isolated demo worktree.

**Architecture:** Keep all changes inside `D:\Project\test\.worktrees\superpowers-parallel-demo`. The controller creates and commits the design and plan, then dispatches two real subagents in parallel with disjoint write scopes so they can each create one file without conflicts. The controller verifies the resulting files, git history, and clean worktree state.

**Tech Stack:** Markdown, Git worktree workflow, Codex spawned subagents

---

### Task 1: Create subagent file 1

**Files:**
- Create: `docs/demo-real-subagent-write-1.md`
- Reference: `docs/plans/2026-03-15-real-parallel-subagent-write-design.md`

**Step 1: Review the approved design**

Read: `docs/plans/2026-03-15-real-parallel-subagent-write-design.md`
Expected: The design confirms this task must create one new file and must not modify any existing files.

**Step 2: Dispatch one real subagent with a single-file scope**

Give the subagent these constraints:
- Only modify `docs/demo-real-subagent-write-1.md`
- Create the file if it does not exist
- Do not touch any other file
- Return the path it changed

Required file structure:
- Title: `# Real Subagent Write 1`
- Section: `## Purpose`
- Section: `## Scope`
- Section: `## Verification`

**Step 3: Verify the file content**

Run: `Get-Content docs/demo-real-subagent-write-1.md`
Expected: The file contains the required sections and only describes subagent 1's scope.

### Task 2: Create subagent file 2

**Files:**
- Create: `docs/demo-real-subagent-write-2.md`
- Reference: `docs/plans/2026-03-15-real-parallel-subagent-write-design.md`

**Step 1: Review the approved design**

Read: `docs/plans/2026-03-15-real-parallel-subagent-write-design.md`
Expected: The design confirms this task must create one new file and must not modify any existing files.

**Step 2: Dispatch one real subagent with a single-file scope**

Give the subagent these constraints:
- Only modify `docs/demo-real-subagent-write-2.md`
- Create the file if it does not exist
- Do not touch any other file
- Return the path it changed

Required file structure:
- Title: `# Real Subagent Write 2`
- Section: `## Purpose`
- Section: `## Scope`
- Section: `## Verification`

**Step 3: Verify the file content**

Run: `Get-Content docs/demo-real-subagent-write-2.md`
Expected: The file contains the required sections and only describes subagent 2's scope.

### Task 3: Execute the two write tasks in parallel and verify the result

**Files:**
- Verify: `docs/demo-real-subagent-write-1.md`
- Verify: `docs/demo-real-subagent-write-2.md`
- Verify: `docs/plans/2026-03-15-real-parallel-subagent-write-design.md`
- Verify: `docs/plans/2026-03-15-real-parallel-subagent-write-demo-plan.md`

**Step 1: Spawn both real subagents before waiting**

Run: dispatch subagent for Task 1
Run: dispatch subagent for Task 2
Expected: Both agents start successfully before the controller waits for results.

**Step 2: Read both returned files**

Run: `Get-Content docs/demo-real-subagent-write-1.md`
Run: `Get-Content docs/demo-real-subagent-write-2.md`
Expected: Both files exist and match their required structure.

**Step 3: Verify git status and diff**

Run: `git status --short`
Run: `git diff -- docs/demo-real-subagent-write-1.md docs/demo-real-subagent-write-2.md`
Expected: Only the two new demo files appear as intended changes before commit.

**Step 4: Commit the two-file result**

Run: `git add docs/demo-real-subagent-write-1.md docs/demo-real-subagent-write-2.md`
Run: `git commit -m "docs: add real parallel subagent write demo"`
Expected: Commit succeeds and records exactly the two new files.

**Step 5: Final verification**

Run: `git status --short`
Run: `git log --oneline -1`
Expected: The worktree is clean and the latest commit is the demo write commit.
