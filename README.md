# Keeper

The Keeper is a partner for building a product with Claude Code: it knows the product, thinks
along, pushes back, notices what is off, refines a wish until it is well defined, and then has
it built, checked and landed. The owner is the creative mind; the Keeper is the designer, the
engineer and the one who keeps things moving.

This repository holds the generic part, the same for every product:

- `core/` — what the Keeper is (`skills/keeper/`), its helpers (`agents/`: one builder, one
  checker, one searcher) and its reminders (`hooks/`). `skills/keeper/owner.md` is personal to
  the owner and is the one file another owner would replace.
- `core/skills/` also holds four skills borrowed unchanged from
  https://github.com/obra/superpowers and kept up to date with it: `brainstorming` (finding out
  what is wanted before anything is built), `systematic-debugging`, `test-driven-development`
  and `verification-before-completion`. See `THIRD-PARTY.md`.
- `cases/` — misses and successes that were looked into, and what was changed because of them.
- `product-template/` — the files a new product starts with.
- `install.sh` — copies `core/` into a product.

Each product keeps its own files in `.claude/keeper/`: what it is (`vision.md`), where it stands
(`state.md`), its areas and backlog (`project.md`), how it is built (`build-rules.md`), and its
own cases.

## Adding the Keeper to a product

1. Copy `product-template/.github/workflows/keeper-refresh.yml` and the files under
   `product-template/.claude/keeper/` into the product.
2. Add the two hooks from `product-template/settings-hooks.json` to the product's
   `.claude/settings.json`.
3. Point the product's `CLAUDE.md` at the Keeper: "Every session is the Keeper: follow
   `.claude/skills/keeper/SKILL.md` from the first message."
4. Start the "Keeper refresh" job once. From then on it runs every hour and brings in changes
   made here.

A Claude session can do all four steps; ask it to "add the Keeper to this product".

## Changing the Keeper

Change it here, never in a product's copy. The copies follow within the hour.
