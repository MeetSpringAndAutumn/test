# Superpowers Parallel Demo Design

**Goal:** Demonstrate a minimal superpowers workflow in Codex that exercises skill selection, isolated worktree setup, task decomposition, parallel execution, and result synthesis.

**Audience:** A user who wants to verify whether superpowers can drive a Codex workflow that resembles subagent usage.

**Constraints:**
- Do not modify existing tracked files in the repository.
- Only add two new Markdown demo artifacts, plus the required design and plan docs.
- Keep the demo inside an isolated git worktree because the main workspace already has unrelated local changes.
- Do not claim that this Codex session has a true subagent dispatch API when only parallel tool calls are available.

**Chosen approach:** Create two independent Markdown tasks in the isolated worktree, execute their supporting checks in parallel, then summarize in the final response how this maps to a real subagent workflow and where the current runtime falls short.

**Artifacts:**
- `docs/demo-parallel-task-1.md`
- `docs/demo-parallel-task-2.md`
- supporting plan/design docs in `docs/plans/`

**Execution model:**
- Use `using-superpowers` to select and load the relevant skills.
- Use `using-git-worktrees` to isolate the demo from the dirty main workspace.
- Use `writing-plans` to produce a step-by-step implementation plan before editing files.
- Use `dispatching-parallel-agents` as the conceptual model, while implementing the demo with parallel Codex tool calls instead of true spawned subagents.

**Success criteria:**
- The demo runs entirely inside the isolated worktree.
- Two new Markdown task files are created without touching existing repo content.
- The final response explains which parts of the superpowers workflow were validated and which parts could only be simulated.
- Final status is backed by fresh verification evidence from git/status checks rather than assumption.
