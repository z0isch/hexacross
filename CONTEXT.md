# Hexacross

A picross/nonogram-style logic puzzle played on a grid of hexagons instead of squares.

## Language

**Puzzle**:
One authored challenge: a Board plus its hidden solution, from which the Clues are derived.
_Avoid_: level, picture, nonogram (as a noun for one puzzle)

**Board**:
The whole grid of Cells for one Puzzle.
_Avoid_: grid (fine informally, but Board is the domain term), map

**Cell**:
One hexagon on the Board, which the player marks.
_Avoid_: hex (as a noun for a board position), tile, square

**Line**:
A straight run of Cells along one of the Board's three axes.
_Avoid_: row, column (they hide that there are three directions, not two)

**Clue**:
The sequence of numbers attached to a Line, giving the lengths of the runs of filled Cells along it, in order.
_Avoid_: hint, number

## Relationships

- A **Puzzle** has exactly one **Board**
- A **Board** is made of **Cells**
- Every **Cell** lies on exactly three **Lines**, one per axis
- A **Line** carries at most one **Clue** (which axes carry Clues is still open)
