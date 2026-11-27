# A swapped-in coordinator ran without the Keeper — resolved, watch for it

**What happened.** In a Claude project, the coordinator (the session the owner talks to in the
project chat) is sometimes replaced by a fresh session. The fresh one had not read the Keeper and
behaved like a plain default Claude: it built before asking, skipped the order, guessed at taste.
Threads it started inherited the same gap. The owner noticed only from the quality dropping
suddenly: "wait, how stupid are you? Oh yes, you're the default you."
**What the owner expected.** The same Keeper every time, whichever session answers.
**Cause.** Being the Keeper depended on a session choosing to read the Keeper files. Product
sessions get that from the product's `CLAUDE.md`, but the coordinator often runs without the
repository and cannot reach GitHub, and a fresh one has no memory of having been told. The only
fallback was a copy of the Keeper in the project's files, which had gone stale.
**What was changed.** The Keeper's core (who does what, reading the owner, the order, design,
and "read the full Keeper first") is now in the project instructions, which every session in the
project gets with no reading step. A weekly scheduled task refreshes the project-files copy of
the full Keeper (the keeper files, agents, cases, and the product's style skill), and when a
change in `SKILL.md`, `owner.md` or `design.md` makes the core block out of date, it sends the
coordinator a proposed new block to put in the project instructions.
