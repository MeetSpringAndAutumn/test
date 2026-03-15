# Demo Task 2: Runtime Capability Audit

## Purpose

This task documents which parts of the superpowers workflow this Codex session can execute directly and which parts can only be simulated.

## Inputs

- Loaded skills relevant to this demo
- Tool families exposed in the current Codex session
- The requirement to avoid overclaiming true subagent support

## Checklist

- Confirm skill selection and sequencing work in this session
- Confirm parallel tool calls can be used for independent tasks
- Confirm there is no exposed `Task` or true subagent dispatch interface in this runtime

## Expected Evidence

- Successful skill-file reads for the selected superpowers skills
- Successful parallel tool invocations for independent checks or writes
- Direct observation that the available tool families do not include a true spawned-subagent API

