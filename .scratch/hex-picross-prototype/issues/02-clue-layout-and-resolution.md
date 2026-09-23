# Clue layout and screen resolution

Type: prototype
Status: resolved
Blocked by: 01

## Question

How should a hexagon-shaped Board and its three axes of Clues be laid out on screen so every Clue is readable and clearly belongs to its Line?

Decide, from a rough runnable Usagi build:

- Hex orientation (pointy-top vs flat-top).
- Cell size in pixels, and the Board radius that comfortably fits.
- Game resolution: keep 320×180, or raise `game_width`/`game_height` in `usagi.conf`.
- Clue placement: which edges hold which axis, how multi-number Clues are stacked or angled, and how a Satisfied Clue greys out.

The build should render a hard-coded Board with derived Clues and support the mouse Marks from the map Notes. That way, this ticket also gives a first hands-on read on whether three-axis Clues feel right. Link the prototype code as the asset.

## Answer

Chosen by playing the prototype's three variants (flat-top with Clues at Line ends, pointy-top with Clues at Line ends, flat-top with a hovered-Cell Clue panel):

- **Orientation:** pointy-top Cells. One axis is horizontal; the other two are steep, so their Clues grow up and down. At 480×270 there is room for that.
- **Resolution:** 480×270 (`game_width`/`game_height` in `usagi.conf`, now set in the real project config).
- **Cell size and radius:** Cell size 16 px (centre to corner) at radius 3 fits with every Clue on screen.
- **Clue placement:** the pinwheel. Each axis's Clue sits at one end of its Lines, so each of the six Board sides holds exactly one axis. Clue numbers are **stepped outward along the Line's own direction**, 10 px apart. Reading from the outermost number toward the Board gives the runs in order from that end of the Line. Clues are not written as horizontal strings, and there are no leader lines.
- **Tying Clues to Lines:** hovering a Cell highlights its three Lines and turns their unsatisfied Clues yellow. There is no per-axis colouring.
- **Satisfied greying:** a Satisfied Clue drawn in dark grey reads clearly. Keep it.
- The hovered-Cell panel (variant C) was not chosen, because Clues fit at the Line ends.

This session didn't give a verdict on whether three-axis Clues are fun. That question is left to the playtest ticket.

Prototype (all three variants plus toggles): branch `prototype/clue-layout`, `prototypes/clue_layout/` (commit be5da69). Run with `git checkout prototype/clue-layout && usagi dev prototypes/clue_layout`.
