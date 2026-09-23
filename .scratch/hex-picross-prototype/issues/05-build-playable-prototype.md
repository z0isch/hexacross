# Build the playable prototype

Type: task
Status: resolved
Blocked by: 04

## Question

Turn the rough builds into the destination: a playable Usagi prototype in the real project (`main.lua` at the repo root) with the six playtested Puzzles, Solved detection (every Clue Satisfied), per-Clue greying, mouse Marks, Auto-Cross, and a minimal way to switch Puzzles. Resolved when it runs under `usagi dev` and every Puzzle can be Solved.

Starting points:

- The playtest build on branch `prototype/playtest` (`prototypes/playtest/`) already does almost all of this. Keep the chosen settings: orange 1 px outline highlight, brown for hovered Satisfied Clues, no guide arrows, Auto-Cross on, Cell size auto-fit per Puzzle. Drop the comparison toggles. See [Playtest hand-authored Puzzles](04-playtest-hand-authored-puzzles.md).
- Copy `puzzles.lua` from that branch as-is (the format is in [Puzzle authoring format](03-puzzle-authoring-format.md)).
- **Puzzle switching** (graduated from the map's fog): decide it here. The playtest build's Left/Right keys, with Marks kept per Puzzle and the name in the HUD, worked. A `usagi.menu_item` or a select screen are the alternatives.

## Answer

Built. The destination is the real project at the repo root: `main.lua`, `puzzles.lua` and `usagi.conf` (renamed Hexacross). Run it with `usagi dev`.

- **Kept from the playtest build:** the Solution format and strict load-time validation, pointy-top pinwheel layout (step 10), and Cell size auto-fit per Puzzle (up to 16, below a 12 px HUD strip). Also: Solved detection (every Clue Satisfied), Satisfied Clues in dark grey, brown while hovered, and a 1 px orange outline on the hovered Cell's three Lines with a thicker ring on the hovered Cell. Auto-Cross is always on, drawn dimmer, and a right-click adopts it. Input is left = Fill, right = Cross, the same Mark again = Blank, and drag-painting. The HUD shows the index, name, Clues Satisfied and the timer, plus a SOLVED banner.
- **Dropped:** every comparison toggle (highlight style, outline colour and thickness, hot-Satisfied colour, guide arrows, Auto-Cross on/off), manual Cell-size keys, the Solution cheat, and the F1 help screen. A one-line control hint sits bottom-right instead.
- **Puzzle switching (decided):** Left/Right arrow keys cycle through the six Puzzles, with Marks and the timer kept per Puzzle in memory. The same actions are also in Usagi's pause menu ("Next Puzzle", "Previous Puzzle", "Clear this Puzzle"), so they can be found without the hint. Backspace clears the current Puzzle. No select screen: with six Puzzles, cycling is enough.
- `puzzles.lua` is copied from `prototype/playtest` unchanged apart from its header comment.

Verified: it launches under Usagi 1.3.3 with no Lua errors, including load-time validation of all six Puzzles. Solvability rests on `check.py` (all six have exactly one solution and are line-solvable) and on the Solved logic, which is unchanged from the playtest, where every Puzzle was solved by hand. The user then played the final build by hand and confirmed it plays great (2026-09-23).
