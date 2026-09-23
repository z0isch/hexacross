# Hex nonogram prior art

Research for [issue 01](../issues/01-hex-nonogram-prior-art.md). Researched 2026-09-23 from web sources. Terms follow `CONTEXT.md` (Puzzle, Board, Cell, Line, Clue, Mark, Satisfied, Solved).

**How reliable this is.** Prior art turned out thin. Nobody has published a design write-up on hexagonal nonograms, and the most relevant games describe their UI only in store blurbs. Several key pages (the Microsoft Store listing, griddlers.net's Triddler rules and tutorial) render client-side and gave no readable text. Each claim below is tagged:
- **[source]**: stated by the cited page.
- **[inference]**: my reading of what a source implies.
- **[derived]**: my own geometry or logic, with no outside source.

## What exists

| Work | What it is | Clue type | Source |
|---|---|---|---|
| **Hex Picross** (Sprovieri Games, Steam, 2022) | Hexagonal Cells, Clues on "each diagonal and column". 240 levels in sizes 3x3x3 to 9x9x9. Mixed reviews (about 51% positive of 43), abandoned. | Appears to be a single **count** per Line, not a run sequence ("counts how many colored cells there are… when all are equal to zero, you've won") [inference] | https://store.steampowered.com/app/2113370/Hex_Picross/ |
| **Nonograms Hexagon** (Microsoft Store, free) | "solve the puzzle from three directions". Hand-crafted picture Puzzles. | Presumably run Clues, unconfirmed | https://apps.microsoft.com/detail/9pmd011k6961 (page text did not render; blurb seen only in search snippets) |
| **Hexcross** (Kaker / kakerdoker, Steam + itch, 2022, Unity) | "hexagonal nonogram puzzles". A level must be finished with 0 mistakes to unlock story. Random generator after the campaign. | Not documented on the store pages | https://store.steampowered.com/app/2127720/Hexcross/, https://kakerdoker.itch.io/hexcross |
| **Hexograph** (Icospheric, itch, in development) | Nonogram "on a hex grid" with "additional rules". 1 to 4 colours. Mouse, keyboard, or gamepad. | Not documented | https://icospheric.itch.io/hexograph |
| **Triddlers** (griddlers.net, about 17,800 puzzles) | Triangular Cells inside a **hexagonal perimeter**, Clues on three axes (horizontal and two diagonals). Standard nonogram run rules. | Run Clues | https://www.griddlers.net/triddlers, https://www.olsak.net/grid.html ("triangular grid with hexagonal circumference"), https://github.com/paulstansifer/number-loom |
| **Hexcells** (Matthew Brown) | Not a nonogram, but the best-known game with **Line Clues on a hex grid**. Numbers sit "at the top of each row, column and diagonal". `{n}` means the n Cells are contiguous, `-n-` means they are not. | Count plus a contiguity flag | https://en.wikipedia.org/wiki/Hexcells, https://steamcommunity.com/sharedfiles/filedetails/?id=320523083 |

Triddlers are the closest mature analogue: three-axis run Clues with a hexagonal outline. The difference is that their Cells are triangles, so a Cell is not crossed by all three axes the way ours are.

## 1. Clue layout around a hexagon Board

**Found:**
- Hexcells puts Line numbers outside the grid at the start of each Line: "above" vertical columns, and at the start of diagonals [source: Wikipedia; Steam guide 320523083]. From screenshots I remember that diagonal hints are drawn rotated to follow their Line, but no page I could read states this, so treat it as unverified.
- Hex Picross shows Clues as numbers in circles. One player asked for "clearer row direction indicators" and "reducing visual clutter from numbered circles" [source: Steam discussion "Some suggestions", https://steamcommunity.com/app/2113370/discussions/0/3380536561710701206/]. Hex Picross also lets the player "click on the column to highlight it" [source: store page]. So even a count-only game had trouble making it clear which Line a Clue belongs to.
- Griddlers.net's triddler rules say only that Clue directions are "horizontal, vertical, or diagonal" (search snippet of https://www.griddlers.net/pages/t_rules). The page body did not render, so the exact placement convention **could not be confirmed**.

**Not found:** no designer write-up anywhere on how to tie a diagonal Clue to its Line, whether through angle, alignment, or leader lines.

**[derived] Geometry worth knowing.** On a hexagon-shaped Board, each end of a Line lands on one of the Board's six sides, and every side collects Line ends from exactly two axes. If each axis shows its Clues at only one end, one choice gives each side exactly one axis:
- axis A on sides 1 and 2
- axis B on sides 3 and 4
- axis C on sides 5 and 6

This is a "pinwheel" layout with 3-fold rotational symmetry. For example, with pointy-top Cells: horizontal Lines on the upper-left and lower-left sides, "/" Lines on the top and upper-right sides, "\" Lines on the bottom and lower-right sides. Any other one-end choice doubles up two axes on some sides and leaves other sides empty.

## 2. Board sizes

- Hex Picross offers 3x3x3, 4x4x4, 5x5x5, 6x6x6, 7x7x7, and 9x9x9 (240 levels). 11x11x11 was promised and never shipped [source: store page; reviews at https://steamcommunity.com/app/2113370/reviews/]. "NxNxN" most plausibly means a hexagon with side N, which is 3N(N−1)+1 Cells: 19, 37, 61, 91, 127, and 217 [inference].
- Players said that without drag-painting, clicking "makes the game really difficult to play when the board gets bigger" [source: Steam reviews]. Large Boards are fine only if input scales with them.
- Triddlers on griddlers.net run large, for example "(25+25)x(25+25)" [source: listing]. These are for dedicated solvers, not a comfortable starting size.
- A hexagon of radius R has 1 + 3R(R+1) Cells [source: https://www.redblobgames.com/grids/hexagons/]. [derived] It has 2R+1 Lines per axis, so 3(2R+1) Clues in total, with Line lengths from R+1 to 2R+1. A Clue has at most ⌈L/2⌉ numbers for a Line of length L.

| Radius | Cells | Clues | Longest Line | Max numbers in a Clue |
|---|---|---|---|---|
| 2 | 19 | 15 | 5 | 3 |
| 3 | 37 | 21 | 7 | 4 |
| 4 | 61 | 27 | 9 | 5 |
| 5 | 91 | 33 | 11 | 6 |

**Not found:** any player or designer statement about a *comfortable* size. Radius 2 to 4 (Hex Picross's 3x3x3 to 5x5x5) is the only sampled range that shipped with players.

## 3. Pointy-top vs flat-top

**Found:**
- Both hex games I found with Line Clues and a clear orientation use **flat-top Cells with vertical columns**. Hex Picross has "each diagonal and **column**". Hexcells has hints "above" columns [source: store page, Hexcells guide; that the Cells are flat-top is my inference from "vertical columns"].
- Red Blob Games is the standard reference on hex geometry. It covers both orientations but does not discuss Clue readability [source: https://www.redblobgames.com/grids/hexagons/].

**Not found:** any source comparing the two orientations for Clue readability.

**[derived] How orientation interacts with Clue placement.** Clue numbers run outward along their Line.
- **Pointy-top Cells:** one axis is horizontal and two are steep (±60° from horizontal). Two of the three Clue sets grow mostly *vertically*.
- **Flat-top Cells:** one axis is vertical and two are shallow (±30° from horizontal). Two of the three Clue sets grow mostly *horizontally*.

On a 16:9 screen such as 320x180, vertical space is scarce. That favours flat-top, and it matches what Hex Picross and Hexcells did. The cost is that the single vertical axis needs its Clue numbers stacked in a column above or below the Board.

## 4. Difficulty: easy, over-constrained, or ambiguous?

**Community evidence, all from Hex Picross, whose Clues are counts rather than runs:**
- "Puzzles are essentially random as there are multiple solutions" and "there are several levels where there is no logical way to start, you have to guess" [source: Steam reviews].
- "Approximately 4 levels require guesswork" and most levels are "overly symmetrical and trivial" [source: https://steamcommunity.com/app/2113370/discussions/0/3463857594041933632/].
- **The symmetry trap.** Hex Boards invite 3- or 6-fold symmetric patterns: "Whenever I make any deduction at all, I copy that same deduction 2 times on the other sides, or even 5 times!" The same poster said the free Microsoft Store hexagon game "doesn't fall into the symmetry trap" [source: https://steamcommunity.com/app/2113370/discussions/0/3422194766260514149/]. This is directly relevant to abstract-pattern Puzzles.
- "Too many levels are too symmetrical and way too easy" [source: "Some suggestions" thread].

**Theory, from discrete tomography.** This field studies reconstructing a shape from line *counts* ("X-rays") taken along several directions:
- With 2 directions, existence, uniqueness, and reconstruction are polynomial. With **3 or more directions they are NP-complete** (Gardner, Gritzmann & Prangenberg, *Discrete Math.* 202, 1999) [source: https://www.sciencedirect.com/science/article/pii/S0012365X98003471].
- On triangular and hexagonal grids with 3 directions, non-uniqueness comes from "switching components": two different fillings with the same projections. Ryser's two-direction theory "has no analog" there [source: search summaries of https://www.researchgate.net/publication/261458200 and https://link.springer.com/chapter/10.1007/978-3-319-32360-2_8; I did not read the full texts].
- Run Clues carry strictly more information than counts, so these results bound the count-only case (Hex Picross), not ours. Deciding whether an ordinary nonogram is solvable is already NP-complete [source: https://en.wikipedia.org/wiki/Nonogram].

**[derived] The smallest ambiguity on our Board.** Take the six Cells around any centre Cell. Fill alternating Cells (3 of the 6) and leave the centre and everything around them Blank. Filling the *other* 3 alternating Cells gives the same Clue on every Line, since each affected Line sees one isolated "1" either way. This is the hex version of the 2x2 diagonal swap on square grids. Neighbouring Filled Cells that join these into longer runs break the tie. Hand-authored Puzzles should check for this pattern.

**Not found:** any evidence either way that three-axis *run* Clues make Puzzles trivially easy or over-constrained. The only claims are anecdotes about one count-based game with symmetric levels. Intuitively, the third axis adds constraints and so tends toward easier, more determined Puzzles. That is untested.

## 5. Input and marking conventions

- **Left-click fills, right-click marks as not-filled.** This holds in both Hexcells ("Right Mouse Button… eliminate cells", guide 320523083) and Hex Picross ("right mouse button to select a 'negative' cell", store page). It matches our Fill/Cross plan.
- **Drag-painting is expected.** Its absence was Hex Picross's most specific control complaint (reviews; "Some suggestions" thread).
- **Line highlighting.** Hex Picross highlights a Line when its Clue is clicked [source: store page]. Players also asked for a third "hypothesis" Mark state and for marking partly finished Lines ("Some suggestions" thread).
- **Hexcross** penalises mistakes ("0 mistakes to unlock the story") [source: itch page]. This is outside our scope, since we have no wrong-Cell feedback.
- **Not found:** any hex-specific drag rule, such as locking a drag to one of the three axes. Our "no axis lock" choice has no precedent either way.

## Implications for the Clue layout prototype

1. **Start with flat-top Cells.** Two of the three Clue axes then grow mostly horizontally, which suits 320x180, and it's what Hex Picross and Hexcells did. Try pointy-top only if the vertical-axis Clue stacks don't fit.
2. **Try the pinwheel layout first.** Put each axis's Clues at one end of its Lines, arranged so each of the six Board sides hosts exactly one axis. This spreads Clues evenly with no side doubled up. The fallback is Clues at both ends of each Line.
3. **Tying Clues to Lines is the known weak spot.** Hex Picross players asked for clearer direction indicators. The prototype should test at least one of these: rotating or aligning each Clue along its Line, or highlighting the hovered Cell's three Lines and their Clues. Hover highlighting is cheap and was already suggested in the map's "Fallback if Clues don't fit".
4. **Size for radius 3 first (37 Cells, 21 Clues of up to 4 numbers).** Check whether radius 4 fits. Hex Picross's smallest shipped sizes (19 to 61 Cells) bracket this range.
5. **For the authoring and playtest tickets:** avoid 3- or 6-fold symmetric patterns, the most specific complaint in the prior art. Also check each Puzzle for the alternating six-Cell ring ambiguity, which is a cheap first test before any solver is written.
