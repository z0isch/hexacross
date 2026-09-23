-- The six playtested Puzzles, in play order (see .scratch/hex-picross-prototype/issues/04-playtest-hand-authored-puzzles.md).
-- Format per ticket 03: '#' Filled, '.' not; spaces ignored; row r holds 2R+1-|r| Cells.
return {
  { name = "Hook", solution = [[
    . # #
   # . . #
  # . . # .
   # # . .
    . # .
  ]] },
  { name = "Comet", solution = [[
     . . . .
    . # # . .
   . # # # . .
  . . # # # . .
   . . . # # .
    . . . . #
     . . . #
  ]] },
  { name = "Spiral", solution = [[
     # # # .
    . . . # .
   # # . . # .
  # . # # . # .
   # . . . # .
    # # # # .
     . . . .
  ]] },
  { name = "Fork", solution = [[
     # . . #
    . # . # .
   . . # # . .
  . . . # # # #
   . . # . . .
    . # . . .
     # . . .
  ]] },
  { name = "Chevrons", solution = [[
     . # . .
    # . # . .
   . # . # # .
  # . . # . # .
   . # # . # .
    . . # . .
     . . . #
  ]] },
  { name = "Weave", solution = [[
      # # . . #
     . . # # . #
    # . . # . . #
   . # # . . # # .
  # . # . # . . # #
   # . . # # . # .
    . # . . # . .
     # # . # . .
      . . # # .
  ]] },
}
