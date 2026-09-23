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

**Mark**:
The player's state for a Cell: **Filled** (the player believes it's part of the solution), **Crossed** (the player believes it isn't), or **Blank** (undecided). Only Filled counts toward satisfying Clues.
_Avoid_: paint, flag

**Satisfied** (of a Clue):
The Filled Cells along the Clue's Line form exactly the runs the Clue describes.

**Solved** (of a Puzzle):
Every Clue on the Board is Satisfied. An arrangement that satisfies every Clue counts as solved even if it differs from the authored solution.
_Avoid_: complete, matching the solution

## Relationships

- A **Puzzle** has exactly one **Board**
- A **Board** is made of **Cells**
- A **Board** is hexagon-shaped
- Every **Cell** lies on exactly three **Lines**, one per axis
- Every **Line**, on all three axes, has exactly one **Clue**
