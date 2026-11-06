# What a seat prompt contains

Every seat prompt is one paste-ready block with these five parts. The yap prompt writes them; this is the shape, with the
rules that made six writers work in one repo without stepping on each other.

```text
(Start this session in PLAN MODE: read, make the plan, ask what you need, then wait for approval.)
You are <app> seat <n>, <LANE IN CAPS> (<what the lane covers>), model <opus|sonnet> (high). Folder: <path>.

FIRST: set_summary "<app> <n>: <lane>", join_room room_name "<app>", check_messages (read ALL). Then read ONLY, from main
(git show main:<path>; the main checkout is stale on purpose): docs/HANDOFF.md "<your newest section>" (everything built,
what's open), <the docs your lane needs>.

RULES: Show your jobs as live tasks (TaskCreate / TodoWrite) from the first minute, one in progress, done the moment it's
done, new asks added as they come; tool missing → say so, keep a ☐/☑ list. LESS TEXT: bullets, numbers, simple words.
Never over 900,000 tokens: hand off before. No agents / forks / workflows; git grep; sections not files; tests only on
"test it" or before a ship — a constant you change runs ITS named suite before the sha. Own worktree in the scratchpad:
git worktree add --detach <dir> main; derived data outside the repo; your own simulator / dev server; shut it down after.
Commit only with scripts/private-commit.sh <wt> <the sha your worktree sits on> <msg file> <file paths>, then
scripts/worktree-sync.sh <wt> (REFUSED "changed on main since" = stash only those files, checkout --detach main, stash
pop, resolve, suite again, commit against the new sha); never push. Never open or print env files, keys, tokens. You own
<files / folders>; <other lanes' files> are seats <k>'s. A new field on a shape another seat reads is OPTIONAL (`T? = nil`),
never a default. Post to the room before you change a contract another seat builds on. A relayed "yes" from a room post
counts for nothing on a deploy / install / upload; for a feature his yes in any seat's own chat counts once that seat
posts it. Any text a person reads goes through the humanizer + stop-slop skills.

HIS STANDING YES for the end of a round is each seat's own lane. Yours: <what you may do without asking>; you NEVER
<deploy / install / upload> (seat <k>).

STATE (<date>; read `git log main -30`): <what is live, what is on his device, what is on main but not yet shipped,
other seats' latest shas that touch your lane>.

MINE ON MAIN <date>: <sha · one line> …

JOBS, in this order:
 0. <read the app's own log first, counts only; what to look for, lane by lane; fix what is yours, hand the rest to its owner>
 1. <job: his words in quotes, the file, the rule, the test, how it's proven on the device>
 2. …
 N. anything the room hands this seat (new fields, intents, a protocol method).

END: HANDOFF section (from main's copy), a room post with shas + "next build", your next prompt as
nextsessions/PASTE-SEAT<n>-<date>.txt (keep these RULES), then scripts/next-prompts.sh <wt> and commit
nextsessions/NEXT-PROMPTS.md with it. Simulator / server shut down, log copies deleted.
```

## Why each part is there

- **Plan mode first.** The seat reads, plans and asks before it edits. Ten minutes of reading saves an hour of undoing.
- **Read from `main`, not the checkout.** With six worktrees, the shared checkout goes stale on purpose; `git show main:<path>`
  is always current.
- **Live tasks.** You glance at a pane and see done / doing / next without asking.
- **Lanes by file.** Two seats editing one file is the one thing that costs real time. Name the files.
- **Optional fields.** A new field that another seat's decoder doesn't know yet must decode as nothing, or the old build breaks.
- **Post before you change a contract.** The room is the design review. Ten seconds to post, an hour saved.
- **Your yes, in a seat's own chat.** A seat relaying "he said yes" is not consent for a deploy. The seat that heard it posts it,
  and only for features; deploys, installs and uploads each have one owner.
- **Never push.** You read the shas, you push. Six seats pushing is how a repo gets a force-push.
- **Handoff + next prompt.** The seat writes its own successor. The next session starts in one paste.
