# Superpowers Parallel Demo Design

**Context:** This is stage 1 of the recorded demo sequence described in `docs/superpowers-subagent-demo-overview.md`.

**Goal:** Demonstrate a minimal superpowers workflow in Codex that exercises skill selection, isolated worktree setup, task decomposition, parallel execution, and result synthesis.

**Audience:** A user who wants to verify whether superpowers can drive a Codex workflow that resembles subagent usage.

**Constraints:**
- Do not modify existing tracked files in the repository.
- Only add two new Markdown demo artifacts, plus the required design and plan docs.
- Keep the demo inside an isolated git worktree because the main workspace already has unrelated local changes.
- Do not claim that this stage proves true spawned-subagent support. It intentionally uses only parallel tool calls because real subagents were not exercised in this stage.

**Chosen approach:** Create two independent Markdown tasks in the isolated worktree, execute their supporting checks in parallel, then summarize in the final response what this stage validates and what remains unverified at this stage.

**Artifacts:**
- `docs/demo-parallel-task-1.md`
- `docs/demo-parallel-task-2.md`
- supporting plan/design docs in `docs/plans/`

**Execution model:**
- Use `using-superpowers` to select and load the relevant skills.
- Use `using-git-worktrees` to isolate the demo from the dirty main workspace.
- Use `writing-plans` to produce a step-by-step implementation plan before editing files.
- Use `dispatching-parallel-agents` as the conceptual model, while intentionally implementing this stage with parallel Codex tool calls instead of true spawned subagents.

**Success criteria:**
- The demo runs entirely inside the isolated worktree.
- Two new Markdown task files are created without touching existing repo content.
- The final response explains what this stage validated and what remained unverified until the later real-subagent follow-up.
- Final status is backed by fresh verification evidence from git/status checks rather than assumption.
