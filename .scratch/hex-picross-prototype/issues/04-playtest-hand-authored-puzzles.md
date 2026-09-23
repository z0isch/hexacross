# Playtest hand-authored Puzzles

Type: prototype
Status: resolved
Blocked by: 02, 03

## Question

Do hand-authored abstract hex Puzzles with three-axis Clues play well: solvable by logic, not trivially easy, not ambiguous?

Author 3–5 abstract-pattern Puzzles in the chosen format, play them in the rough build, and decide. The rough build to start from is the Clue layout prototype on branch `prototype/clue-layout`. Run it with the chosen layout: variant B, Cell size 16, step 10, at 480×270.

- Are they solvable without guessing? If not, does the uniqueness checker (map fog) graduate to a ticket?
- What Board size(s) feel right?
- Do the input and per-Clue greying from the map Notes hold up, or does anything need to change before the final build?

## Answer

Verdict: **yes, they play well.** Hand-authored abstract hex Puzzles with three-axis Clues feel good to solve by logic, with a real spread from easy to harder.

- **Puzzle set:** all six candidates go into the final build, in this order: Hook (R2), Comet, Spiral, Fork, Chevrons (R3), Weave (R4). That's one more than the old "3–5", so the destination now says six.
- **Ambiguity isn't the risk. Too easy is.** `check.py` (on the prototype branch) checks two things: whether a Puzzle has exactly one solution, and whether single-Line logic alone solves it. All six pass both. As a baseline, of random Boards at radius 2–4 and 30–60% Filled, 97–100% have exactly one solution and 95–100% are solvable by line logic alone. Three-axis Clues are very constraining. The useful dial is difficulty: the number of strict line-logic rounds (2 for Comet and Spiral, 3–4 for Fork, Chevrons and Weave). **The uniqueness checker doesn't graduate.** It's ruled out of scope, and `check.py` stays on the branch as an optional authoring aid.
- **Board sizes:** radius 2, 3 and 4 all earn a place. Cell size is auto-fit per Puzzle: the largest size up to 16 at which the Board and every Clue fit in 480×270, below a 12 px HUD strip. Radius 4 shrinks automatically.
- **Hover highlight (changed):** the old light-grey overlay at 30% couldn't be seen on Filled or Crossed Cells. Replace it with a **1 px orange outline** (`COLOR_ORANGE`) on every Cell of the hovered Cell's three Lines. The hovered Cell itself gets a thicker orange ring. Unsatisfied Clues on hovered Lines stay yellow. Also tried: indigo/peach tint, pink, and yellow/purple outlines, and 2 px outlines.
- **Satisfied greying (extended):** a Satisfied Clue stays dark grey, but turns **brown** (`COLOR_BROWN`) while its Line is hovered, so you can still see you're on it.
- **Guide arrows:** tried faint arrows through each Line pointing to its Clue (hovered Lines only, or all Lines). **Not wanted.**
- **Auto-Cross (new):** when a Line becomes Satisfied, the game Crosses every Blank Cell on it. Auto-Crosses are re-derived every frame: clear them all, then re-Cross the Blank Cells on each Satisfied Line. So un-filling a Cell removes the auto-Crosses that no longer apply. Manual Crosses are tracked separately and never removed. Auto-Crosses are drawn dimmer. Right-clicking one adopts it as a manual Cross, and left-clicking Fills it as usual. The trigger is Satisfied (exact runs), not the Filled count, so it gives nothing away. **Auto-Cross** is now a term in `CONTEXT.md`.
- **Input:** left = Fill, right = Cross, clicking the same Mark again = Blank, and drag-painting with no axis lock all held up. No changes.
- **Puzzle switching in the playtest build:** Left/Right arrow keys, with Marks kept per Puzzle in memory, plus the name and index in the HUD. This worked fine for playtesting, and the final build can reuse it.

Prototype: branch `prototype/playtest`, `prototypes/playtest/` (commit 4a936cf): `main.lua` (playtest build with toggles for every variant above), `puzzles.lua` (the six Puzzles), `check.py` (uniqueness, line-solvability and rounds report). To run it: `git checkout prototype/playtest && usagi dev prototypes/playtest`. Checker: `python prototypes/playtest/check.py`.
