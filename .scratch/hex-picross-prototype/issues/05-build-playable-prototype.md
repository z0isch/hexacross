# Build the playable prototype

Type: task
Status: open
Blocked by: 04

## Question

Turn the rough builds into the destination: a playable Usagi prototype in the real project (`main.lua` at the repo root) with the six playtested Puzzles, Solved detection (every Clue Satisfied), per-Clue greying, mouse Marks, Auto-Cross, and a minimal way to switch Puzzles. Resolved when it runs under `usagi dev` and every Puzzle can be Solved.

Starting points:

- The playtest build on branch `prototype/playtest` (`prototypes/playtest/`) already does almost all of this. Keep the chosen settings: orange 1 px outline highlight, brown for hovered Satisfied Clues, no guide arrows, Auto-Cross on, Cell size auto-fit per Puzzle. Drop the comparison toggles. See [Playtest hand-authored Puzzles](04-playtest-hand-authored-puzzles.md).
- Copy `puzzles.lua` from that branch as-is (the format is in [Puzzle authoring format](03-puzzle-authoring-format.md)).
- **Puzzle switching** (graduated from the map's fog): decide it here. The playtest build's Left/Right keys, with Marks kept per Puzzle and the name in the HUD, worked. A `usagi.menu_item` or a select screen are the alternatives.
