# Clue layout and screen resolution

Type: prototype
Status: open
Blocked by: 01

## Question

How should a hexagon-shaped Board and its three axes of Clues be laid out on screen so every Clue is readable and clearly belongs to its Line?

Decide, from a rough runnable Usagi build:

- Hex orientation (pointy-top vs flat-top).
- Cell size in pixels, and the Board radius that comfortably fits.
- Game resolution: keep 320×180, or raise `game_width`/`game_height` in `usagi.conf`.
- Clue placement: which edges hold which axis, how multi-number Clues are stacked or angled, and how a Satisfied Clue greys out.

The build should render a hard-coded Board with derived Clues and support the mouse Marks from the map Notes. That way, this ticket also gives a first hands-on read on whether three-axis Clues feel right. Link the prototype code as the asset.
