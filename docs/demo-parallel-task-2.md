# Demo Task 2: Runtime Capability Audit

> This file belongs to stage 1 of the recorded demo sequence. See `docs/superpowers-subagent-demo-overview.md` for the relationship between the pseudo-parallel and real-subagent demos.

## Purpose

This task documents what the stage 1 pseudo-parallel demo can verify directly and what remained unverified until the later real-subagent follow-up.

## Inputs

- Loaded skills relevant to this demo
- Tool families used in the stage 1 demo
- The requirement to avoid overclaiming what this stage proves

## Checklist

- Confirm skill selection and sequencing work in this session
- Confirm parallel tool calls can be used for independent tasks
- Confirm this stage relies on main-session tool calls and therefore does not verify true spawned-subagent support by itself

## Expected Evidence

- Successful skill-file reads for the selected superpowers skills
- Successful parallel tool invocations for independent checks or writes
- Direct observation that this stage uses only main-session tool calls; true spawned-subagent support is verified separately in the stage 2 demo
