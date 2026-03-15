# Codex Worktree Demo Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create a Markdown tutorial that helps a beginner complete one full Codex Desktop worktree workflow.

**Architecture:** Add a short planning artifact for traceability, then create a standalone tutorial in `docs/` with a practical structure: intro, prerequisites, walkthrough, explanation, FAQ. Keep examples concrete and avoid tool-specific claims that cannot be verified locally.

**Tech Stack:** Markdown, Git worktree commands, Codex Desktop local workspace workflow

---

### Task 1: Create the user-facing tutorial

**Files:**
- Create: `docs/codex-desktop-worktree-quickstart.md`

**Step 1: Draft the introduction**

Write a short opening that explains:
- what `git worktree` is
- why it is useful when using Codex Desktop
- what the reader will complete by following the tutorial

**Step 2: Add prerequisites**

List the minimum assumptions:
- Git is installed
- the current folder is already a Git repository
- the user can open a local folder in Codex Desktop

**Step 3: Write the walkthrough**

Include copyable commands for:
- checking repository state
- creating a worktree with a new branch
- entering the worktree directory
- opening or using that directory in Codex Desktop
- removing the worktree after finishing

**Step 4: Add short explanations**

Briefly explain:
- worktree and branch relationship
- why worktree is better than repeated checkout for parallel tasks

**Step 5: Add FAQ**

Cover:
- whether the worktree is a full copy
- whether deleting a worktree deletes the branch
- when worktree is not necessary
