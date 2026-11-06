# The loop

"Loop engineering" here means the seats keep going without you prompting them, and what they do next comes from
evidence, not from the last thing you typed. Four pieces make that work.

## 1. The app's own log

The app writes one line per thing it did or decided, `ISO-time  lane: message`, to a file on the device (Nudgy's is
`Application Support/Ledger/brain.log`). Lanes are short words: `places:`, `cards:`, `capture:`, `launch:`. Counts and
states only, never the user's words. A seat's first job every round is to copy that log off the device, count the lines in
its lanes, and fix what the counts say is broken. The log is the test that runs all day on a real phone.

A rule worth keeping: lanes that carry what a person said are counted, never printed.

## 2. Tests, when they matter

A named test per rule (a pure function with a `Rule` enum and a `Tests` struct), the whole suite before any commit, and
never a suite run because something compiled. Each seat has its own simulator or server so suites don't collide.
"Test it" from you, or a ship, is what triggers the big runs.

## 3. Handoff and the next prompt

At the end of a round a seat writes three things:

- a section at the top of `docs/HANDOFF.md`: a table of shas and what each did, what the log showed, what's open;
- a room post: the shas, what the next build should carry, anything another seat must know;
- `nextsessions/PASTE-SEAT<n>-<date>.txt`: its own successor's prompt, same RULES, updated STATE and JOBS.

`scripts/next-prompts.sh` reads the newest prompt per seat from `main` and writes `nextsessions/NEXT-PROMPTS.md`, plus a
copy on your Desktop. Starting the next round is six pastes.

## 4. Picks, not opinions

Anything visible gets built as A and B behind a debug switch, shot on the same device in the same state, and shown as one
board (columns A / B, rows screens). You pick a letter. The winner becomes the default, the loser's code is deleted, the
board records why. The seats never argue about taste; they build both and ask.

## Commits with six writers

`scripts/private-commit.sh <worktree> <base sha> <message file> <paths…>` commits only the named files onto `main`
through a private index. It refuses when a file changed on `main` since the base sha (someone else landed first), when
there are conflict markers, or when nothing changed. Then `scripts/worktree-sync.sh <worktree>` moves the worktree to
`main` once every local edit is on it. No merges, no shared index, no lost work. Nobody pushes; you push.

## What stays yours

- yes to a deploy, an install, an upload, a submit (each has one owning seat; the seat asks in its own chat)
- picks on boards
- secrets (seats never open `.env*`; a program may load one, its messages say only "missing" or "rejected")
- the push
