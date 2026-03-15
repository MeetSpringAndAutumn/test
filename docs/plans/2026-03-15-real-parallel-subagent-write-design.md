# Real Parallel Subagent Write Demo Design

**Goal:** Demonstrate that this Codex environment can dispatch two true subagents in parallel and have them write to two separate files without conflicts.

**Audience:** A user validating whether the current session supports real parallel subagents with independent write scopes.

**Constraints:**
- Perform all writes inside `D:\Project\test\.worktrees\superpowers-parallel-demo`.
- Do not modify existing demo files created in the earlier workflow.
- Use two true subagents, not parallel tool calls in the main session.
- Keep each subagent's write scope to a single new Markdown file.

**Chosen approach:** Create two new Markdown files under `docs/`, one per subagent. Each subagent receives a focused prompt with one target file, a required section structure, and a no-other-files constraint. The controller then verifies each file and confirms the resulting git state.

**Artifacts:**
- `docs/demo-real-subagent-write-1.md`
- `docs/demo-real-subagent-write-2.md`
- supporting design and plan docs under `docs/plans/`

**Execution model:**
- Write and commit the design and plan in the isolated demo worktree.
- Spawn two real subagents in parallel.
- Give each subagent one disjoint write target.
- Review the created files and verify the worktree status afterward.

**Success criteria:**
- Both new files are created by separate subagents.
- No existing files are modified.
- The worktree ends in a clean state after the demo commits.
- Final verification distinguishes true subagent writes from main-session parallel tool calls.
