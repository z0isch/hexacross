# Puzzle authoring format

Type: grilling
Status: resolved
Blocked by: 02

## Question

How is a Puzzle's solution written down so it's quick to author and review by hand?

Candidates: an ASCII-art string shaped like the hexagon Board (leaning toward this), a Lua table of coordinates, or JSON in `data/` via `usagi.read_json`. Also decide where Puzzle files live and what the in-code coordinate system for Cells and axes is (axial / cube), since the format has to map onto it. Clues are always derived from the solution, never hand-written.

## Answer

- **Format:** each Solution is an ASCII-art string laid out like the Board. Each text row is one horizontal Line (constant `r`), and alternate rows are indented half a Cell, so it looks like the pointy-top Board:
  ```
    . # .
   # . # .
  . # # # .
   # . . #
    . # .
  ```
- **Location:** one `puzzles.lua` module at the project root returns an ordered list of Puzzles. Each Solution sits in a Lua long string `[[ ... ]]`. List order is the switching order.
- **Entry shape:** `{ name = "Ring", solution = [[ ... ]] }`. The only metadata is a short `name` for the switching UI.
- **Coordinates:** axial `(q, r)`, `s = -q - r` derived, origin at the centre Cell, `r` growing downward. This is the same as the Clue layout prototype, so its Clue-derivation and hit-test code carries over.
- **Parsing:** `#` = Filled in the Solution, `.` = not Filled. Spaces are ignored, since indentation is only for looks. Blank leading and trailing lines are dropped. The radius comes from the row count, which must be `2R+1`. Row `r` must hold `2R+1 - |r|` Cells. Any other character, or a wrong row count or row length, is an `error()` at load that names the Puzzle and the row.
- **Clues** are always derived from the Solution, never hand-written.
- **Glossary:** **Solution** is now a term in `CONTEXT.md`.
