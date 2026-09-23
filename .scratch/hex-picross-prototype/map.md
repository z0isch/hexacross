# Map: Hex picross prototype

Label: wayfinder:map

## Destination

A playable Usagi prototype of hex-picross: 3–5 small, hand-authored, abstract-pattern Puzzles on hexagon-shaped Boards, with Clues on all three axes. It is mouse-played, detects when a Puzzle is Solved, and has a minimal way to switch between Puzzles. Its purpose is to find out whether three-axis Clues make Puzzles that are fun and solvable by logic.

## Notes

- **Execution is allowed on this map** (overrides wayfinder's plan-only default). Prototype tickets produce real, runnable Usagi code, and the last ticket is the playable build itself. Build work still has to earn its place by settling a decision or reaching the destination.
- Engine: Usagi 1.3.3, Lua 5.5. API reference is `USAGI.md` at the repo root; entry point is `main.lua`. Hexes are drawn with `gfx.tri_fill`; input is `input.mouse*`.
- Vocabulary: use `CONTEXT.md` (Puzzle, Board, Cell, Line, Clue, Mark, Satisfied, Solved). Say "Line", never "row/column".
- Skills: `/grilling` + `/domain-modeling` for grilling tickets, `/prototype` for prototype tickets, `/research` for research tickets.
- Rules settled while charting (these live in `CONTEXT.md`, not in tickets):
  - Board is hexagon-shaped.
  - Clues are on all three axes.
  - Solved means every Clue is Satisfied, not "matches the authored solution".
  - Marks are Filled / Crossed / Blank.
  - Feedback is per-Clue only: a Satisfied Clue greys out. There's no wrong-Cell feedback.
  - Puzzles are abstract patterns, not pictures.
- Input for the first build: left = Fill, right = Cross, click again = Blank; drag-painting with no axis lock.
- Research findings go in `.scratch/hex-picross-prototype/research/` (charted before this was a git repo). Prototypes are captured on throwaway `prototype/<name>` branches.

## Decisions so far

<!-- one line per closed ticket: - [<title>](issues/NN-slug.md) — <gist> -->
- [Hex nonogram prior art](issues/01-hex-nonogram-prior-art.md) — little prior art; start flat-top Cells, pinwheel Clue layout, radius 3; tying Clues to Lines is the known weak spot; avoid symmetric Puzzles and the alternating six-Cell-ring ambiguity; drag-painting expected
- [Clue layout and screen resolution](issues/02-clue-layout-and-resolution.md) — pointy-top, 480×270, Cell size 16 at radius 3; pinwheel Clues stepped along each Line (10 px); hover highlights the three Lines; Satisfied Clues grey out; prototype on branch `prototype/clue-layout`

## Not yet specified

- **Uniqueness checker / solver.** A small offline tool that tells whether a Puzzle has exactly one solution and needs no guessing. Whether it's needed depends on how the hand-authored Puzzles play in the playtest ticket. If they keep turning out ambiguous, this graduates. The [prior-art research](issues/01-hex-nonogram-prior-art.md) already found one ambiguous pattern: fill every other Cell of a six-Cell ring around a Blank centre, with nothing Filled next to it, and the other three Cells give identical Clues. So the checker looks likely to graduate.
- **Board size per Puzzle.** Radius 3 at Cell size 16 is known to fit at 480×270. Still open: whether every Puzzle uses radius 3, or whether radius 2 or 4 (the latter would need a smaller Cell size) earns a place. The playtest will show this.
- **Puzzle switching.** The minimal UI for moving between Puzzles (keys, a menu item via `usagi.menu_item`, a select screen). Probably small enough to decide during the final build.

## Out of scope

- Puzzle generator and in-game Puzzle editor.
- Saving progress or completion across sessions.
- Keyboard / gamepad cursor input.
- Sound, music, juice, and visual polish.
- `usagi export` / web builds.
- Picture Puzzles (whether hex Boards can reveal recognisable images is a separate effort).
- Wrong-Cell feedback / mistake counting.
