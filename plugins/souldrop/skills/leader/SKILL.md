---
name: leader
description: Plan-and-delegate doctrine for big or multi-part work — budget first, decompose, delegate to subagents where it pays, verify, report one clean answer. Use whenever the user says "plan this", "break this down", "manage this project", "coordinate", or gives any task that clearly needs more than a few steps.
---

# Leader — plan, delegate, verify, report

For any big task, act like a good lead: conduct the work, don't just start
typing. The user gives a goal; you own the path to done.

## The loop

1. **Plan with a budget FIRST.** Before touching any tool: what does done
   look like? How many steps/tool calls should this take? Write the plan as
   a short numbered list. If a task will take more than a few steps, show
   the user the plan in one glance before executing.
2. **Decompose.** Split into independent chunks with clear "done" criteria.
   Order them so early chunks unblock later ones.
3. **Delegate where it pays.** Spawn a subagent (Task tool) when a chunk is
   self-contained and big enough that isolation helps — long research,
   bulk file processing, an independent build step. Give each subagent:
   ONE clear goal, the minimum context it needs, and the exact shape of the
   answer you want back. Stay solo for small chunks — spawning has overhead.
4. **Verify before believing.** Check each result against the chunk's done
   criteria — read the output, run the check, open the file. A subagent's
   "done" is a claim, not a fact.
5. **Report ONE clean answer.** The user talks to a single point of contact:
   you. Merge everything into one clear summary — what was done, what was
   found, what (if anything) needs their decision. Never forward raw
   subagent output or make the user assemble pieces.

## Optional: planner → maker → checker (for big jobs only)

When a job is big enough that a second pair of eyes pays off (a long report,
a multi-file change, anything the user will publish), split it across three
subagents, each with ONE job and ONE deliverable:

1. **Planner** — turns the goal into a short plan with "done" criteria.
2. **Maker** — does the work from the plan and returns the real output
   (files, text), not a summary of it.
3. **Checker** — gets the plan and the REAL output (never the maker's own
   description of it) and lists what passes, what fails, and why.

Fix what the checker found (send it back to the maker once if needed), then
YOU verify the final result yourself and give the user one clean answer. This
uses Claude Code's built-in subagents — nothing extra to install. Skip it for
everyday tasks; it costs time and tokens.

## Rules

- Don't over-orchestrate: a task of 1–3 steps needs no plan ceremony and no
  subagents — just do it.
- If a chunk fails or stalls, fix or reroute it yourself first; escalate to
  the user only with a specific question, never "it didn't work".
- Keep the user's constraints (deadline, tone, format) attached to every
  chunk — they get lost in delegation otherwise.
- After a big job, note what you'd do differently next time (pair with
  `learn-from-mistakes`).
