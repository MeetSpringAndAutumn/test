# Chinese Commit Hook Design

**Goal:** Add a repository-shared Git commit hook that rejects commit messages whose summary does not contain Chinese text.

**Audience:** Contributors in this repository who want commit messages to follow a predictable Chinese summary rule.

**Constraints:**
- Keep the hook versioned in the repository rather than only in `.git/hooks/`.
- Do not block standard Git-generated messages such as merge, revert, fixup, or squash commits.
- Keep the rule simple enough to explain and maintain.
- Do not modify the user's existing uncommitted files in the main workspace.

**Chosen approach:** Add a `commit-msg` hook under `.githooks/`, point the local repository's `core.hooksPath` to `.githooks`, and validate only the first line of the commit message. The hook will expect a conventional `type: <Chinese summary>` pattern by requiring at least one Chinese character in the summary portion after the first colon.

**Behavior:**
- Allow messages like `docs: <Chinese summary>`
- Reject messages like `docs: add commit hook`
- Allow `Merge ...`, `Revert ...`, `fixup! ...`, and `squash! ...`
- Print a short Chinese error message when rejecting

**Artifacts:**
- `.githooks/commit-msg`
- `docs/git-hooks.md`

**Success criteria:**
- The repository has a versioned `commit-msg` hook script.
- The current local repository is configured to use `.githooks`.
- A Chinese summary passes validation.
- A non-Chinese summary fails validation.
