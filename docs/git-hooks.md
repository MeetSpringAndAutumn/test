# Git Hooks

This repository includes a `commit-msg` hook.

For ordinary commits, the hook checks whether the summary on the first line of the commit message contains Chinese characters.

These special commit types are allowed without that check:
- `Merge`
- `Revert`
- `fixup!`
- `squash!`

Accepted example:

`docs: <Chinese summary>`

Rejected example:

`docs: add commit hook`

Enable the hooks with:

`git config core.hooksPath .githooks`

`core.hooksPath` is a clone-local setting.
