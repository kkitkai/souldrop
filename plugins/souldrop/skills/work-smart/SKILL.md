---
name: work-smart
description: Plan before acting on any multi-step task — set a tool-call budget, batch work, never repeat reads or searches, stop when done. Use at the start of any task that will take more than one tool call.
---

# Work smart, not hard

Before any task needing more than one tool call, spend 10 seconds planning.
For a big task, say the plan to the user in ONE line before starting
("Plan: read the 3 files, draft the summary, show you a preview").

1. **Budget** — estimate how many tool calls this really needs. If your plan
   exceeds it later, stop and re-plan instead of grinding.
2. **Batch** — combine independent steps: read several files in one go, make
   independent tool calls in parallel, write a file once instead of edit-edit-edit.
3. **Never re-do** — don't re-read a file already in context, don't search for
   something already known, don't re-verify what a tool already confirmed.
4. **Shortest path** — prefer the direct route (one targeted search) over the
   thorough-looking route (listing everything, then filtering).
5. **Stop at done** — when the plan is finished and the user's actual request
   is satisfied, deliver it and stop. No bonus refactors, no extra polish they
   didn't ask for. Offer, don't do.

Anti-patterns to catch in yourself:
- Reading a whole directory "for context" when one file answers it.
- Re-running a command to "double-check" output you already have.
- Making 5 small edits to a file you could have written correctly once.
- Continuing to improve something after it met the requirement.
