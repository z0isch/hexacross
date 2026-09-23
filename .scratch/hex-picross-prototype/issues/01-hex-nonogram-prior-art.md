# Hex nonogram prior art

Type: research
Status: resolved
Blocked by:

## Question

What have existing hexagonal nonogram / picross games and puzzle collections done, and what does that tell us before building? Specifically:

- **Clue layout.** Where do Clues for the three axes sit around a hexagon-shaped Board? How is each Clue visually tied to its Line (angle, alignment, leader lines)?
- **Board sizes.** What radii / Cell counts are typical and comfortable to play?
- **Hex orientation.** Pointy-top or flat-top, and does orientation interact with Clue readability?
- **Difficulty.** Is there known evidence (from designers, puzzle communities, or papers) that three-axis Clues make Puzzles trivially easy, over-constrained, or prone to multiple solutions?
- **Input and marks.** Any hex-specific conventions for filling, crossing, and drag-painting.

Capture findings, with sources, in `.scratch/hex-picross-prototype/research/hex-nonogram-prior-art.md`.

## Answer

Prior art is thin. The main examples are Hex Picross (Steam, count-only Clues on flat-top "columns and diagonals", sizes 3x3x3 to 9x9x9), Nonograms Hexagon (Microsoft Store), Hexcross, and griddlers.net Triddlers (triangular Cells, hexagonal outline, three-axis run Clues). Hexcells is the main reference for Line Clues on a hex grid. No published designer write-up on Clue layout or orientation was found.

- **Clue layout:** Clues sit at the start of each Line. How each Clue is tied to its Line is the known weak spot: Hex Picross players asked for clearer direction indicators, and the game highlights a Line when its Clue is clicked. A "pinwheel" layout gives each of the six Board sides exactly one axis's Clues (derived here, not taken from a source).
- **Orientation:** Hex Picross and Hexcells both use flat-top Cells with vertical columns. Flat-top also suits 320x180 (derived): two axes' Clues grow mostly horizontally.
- **Board size:** radius 3 (37 Cells, 21 Clues of up to 4 numbers) is the suggested starting point.
- **Difficulty:** there is no evidence about three-axis *run* Clues. The count-only Hex Picross was criticised for multiple solutions, guessing, and 3- or 6-fold symmetric, trivial levels. Discrete tomography shows three-direction count reconstruction is NP-complete, with switching components. On our Board, filling alternating Cells of an isolated six-Cell ring is ambiguous (derived).
- **Input:** left-click fills and right-click crosses in both Hexcells and Hex Picross. Missing drag-painting was a top complaint.

Full findings and sources: [../research/hex-nonogram-prior-art.md](../research/hex-nonogram-prior-art.md)
