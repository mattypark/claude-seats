# Yap to six

Paste this into ONE seat, then paste your dictation transcript under it. Claude answers with six prompts, one per seat.

---

I just talked for a while about an app I want to build. The transcript is below, unedited, with links. Turn it into six Claude Code seat prompts that six sessions can run at the same time in one repo, talking to each other through the `claude-multiplayer` room.

Do this in order, and show your work only where I ask for it.

1. **Read the whole transcript once.** Pull out: what the app is in one line, the screens or surfaces it has, the platforms (iPhone, Mac, web, server), every reference link and what I liked about it, every feature I named, and anything I said twice (that's what I care about).

2. **Cut the work into six lanes.** A lane is a set of files one seat owns and nobody else edits. Name the lane and its files. The usual split for an app with a server: backend · frontend · background services and state · components and looks · the hard signals (sensors, audio, location, data pipelines) · desktop and site. Change it to fit this app; if the app is smaller, two seats can share a lane by file, never by feature.

3. **Pick a model and effort per lane.** Opus for lanes that reason across many files or hold protocols other seats build on. Sonnet for lanes with many small, well-shaped edits (screens, copy, components). High effort everywhere at the start. Say why in five words.

4. **Write the six prompts.** Each one is a paste-ready block that starts with: `(Start this session in PLAN MODE: read, make the plan, ask what you need, then wait for approval.)` and then follows `prompts/seat-template.md`: FIRST (join the room, read the handoff), RULES (the shared rules, verbatim), STATE (what exists today), JOBS (numbered, in order, each with how it's proven), END (handoff, room post, next prompt). Use my words for the features; quote me where it helps.

5. **Set up the loop.** In every prompt's RULES put: tests on "test it" or before a ship, never after every build; the app's own log is what you read to know if a thing worked; every round ends with a handoff section in `docs/HANDOFF.md`, a room post with the shas, and a new `nextsessions/PASTE-SEAT<n>-<date>.txt` so the next session starts from where this one stopped; `scripts/next-prompts.sh` collects them. Say which seat owns the eval or test harness.

6. **Write the room protocol.** Who posts what: a seat posts BEFORE it changes a shape another seat reads (an API field, a state type, a note id). A relayed "yes" from the room is not my yes for a deploy or an install; my yes in a seat's own chat is. Deploys, installs and uploads belong to one named seat each. Nobody pushes; I push.

Give me: the six prompts as six fenced `text` blocks, in seat order, then a short table (seat · lane · model · effort · owns deploy / install / tests). Nothing else.

Transcript:
