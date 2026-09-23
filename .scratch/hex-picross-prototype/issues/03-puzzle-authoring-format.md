# Puzzle authoring format

Type: grilling
Status: open
Blocked by: 02

## Question

How is a Puzzle's solution written down so it's quick to author and review by hand?

Candidates: an ASCII-art string shaped like the hexagon Board (leaning toward this), a Lua table of coordinates, or JSON in `data/` via `usagi.read_json`. Also decide where Puzzle files live and what the in-code coordinate system for Cells and axes is (axial / cube), since the format has to map onto it. Clues are always derived from the solution, never hand-written.
