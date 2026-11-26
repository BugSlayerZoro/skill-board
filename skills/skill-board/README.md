# /skill-board

Drives a GitHub Project board on its own: drag a card into `Ready`, and it comes back merged with evidence on the PR.

## What It Does

- **Plans waves from your dependency graph.** Every `Ready` card whose `## Blocked by` issues have all closed runs in the same wave. A `Blocked` card whose blockers closed is swept back to `Ready`; a dependency line it cannot read is flagged, never guessed.
- **Runs each card through three lanes**: super-build (Building), super-qa (QA), super-review (Review). A failed lane bounces the card back with comments the next wave reads.
- **Merges only through the merge gate**: a lock, the current base merged in, your `verify_commands`, then a squash-merge pinned to the reviewed commit.
- **Holds no state of its own.** The board is the state, so Ctrl-C, restarts and rate-limit pauses lose nothing. Stranded `Building` cards return to `Ready`.
- **Pauses near your Claude usage limit** when the usage check is recording (see the pack README).
- **Never writes product code.** Your session is the orchestrator; lane agents do the work.

## When To Use It

- You have a GitHub Project of cards with acceptance criteria and want them built, tested and reviewed unattended.
- You want to harden code that already exists: label those cards `qa` and they skip Building (QA and Review only).

## Verbs

| Command | Does |
|---|---|
| `/skill-board onboard` | One-time setup; checks the board's columns, writes the config |
| `/skill-board lint` | Flags vague or missing ACs and unreadable `Blocked by` lines before a run |
| `/skill-board status` | Read-only 80-column board snapshot (~1.3s, pure Python) |
| `/skill-board run <slug> [--low\|--high]` | The loop; also the resume command |
| `/skill-board stop` | Posts "stopped mid-flight" notes, releases claims, stops workers |

## Install

Part of the skill-board pack: `./install.sh /path/to/project`. Needs `gh` (authenticated), `jq`, bash 3.2+, a GitHub Project (v2) with a `Status` field, dynamic workflows on in `/config`, and the [mattpocock/skills](https://github.com/mattpocock/skills) pack. Ships `pr-security-review` (run by the Tester in QA on every PR); `get.sh` and onboard also add Cloudflare's on-demand [`security-audit`](https://github.com/cloudflare/security-audit-skill). Full reference: [`docs/skill-board/README.md`](../../docs/skill-board/README.md).
