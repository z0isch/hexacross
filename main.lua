-- Hexacross: hex picross with Clues on all three axes.
-- Vocabulary is in CONTEXT.md. Layout: pointy-top Cells, pinwheel Clues stepped along each Line.

local SQRT3 = math.sqrt(3)
local BLANK, FILLED, CROSSED = 0, 1, 2
local STEP = 10
local MAX_SIZE = 16
local HUD_H = 12

local PUZZLES = require "puzzles"

-- Axial step along each axis's Lines; each Clue sits at the +step end (the pinwheel).
local AXES = {
  { step = { 0, -1 } },
  { step = { 1, 0 } },
  { step = { -1, 1 } },
}

local function line_value(axis_i, q, r)
  if axis_i == 1 then return q end
  if axis_i == 2 then return r end
  return -q - r
end

-- Rows of '#'/'.', spaces ignored, blank edge lines dropped,
-- 2R+1 rows, row r holds 2R+1-|r| Cells. Anything else is a load-time error.
local function parse_solution(name, text)
  local rows = {}
  for ln in (text .. "\n"):gmatch("([^\n]*)\n") do
    rows[#rows + 1] = ln:gsub("[ \r\t]", "")
  end
  while #rows > 0 and rows[1] == "" do table.remove(rows, 1) end
  while #rows > 0 and rows[#rows] == "" do table.remove(rows) end
  if #rows % 2 == 0 then error(name .. ": needs an odd row count (2R+1), got " .. #rows) end
  local R = (#rows - 1) // 2
  local filled = {}
  for i, row in ipairs(rows) do
    local r = i - 1 - R
    local want = 2 * R + 1 - math.abs(r)
    if #row ~= want then
      error(string.format("%s: row %d has %d Cells, expected %d", name, i, #row, want))
    end
    local qmin = math.max(-R, -r - R)
    for k = 1, #row do
      local ch = row:sub(k, k)
      if ch == "#" then
        filled[(qmin + k - 1) .. "," .. r] = true
      elseif ch ~= "." then
        error(string.format("%s: row %d has bad character '%s'", name, i, ch))
      end
    end
  end
  return R, filled
end

local function runs_of(cells, pred)
  local out, n = {}, 0
  for _, c in ipairs(cells) do
    if pred(c) then
      n = n + 1
    elseif n > 0 then
      out[#out + 1] = n
      n = 0
    end
  end
  if n > 0 then out[#out + 1] = n end
  return out
end

local function same(a, b)
  if #a ~= #b then return false end
  for i = 1, #a do
    if a[i] ~= b[i] then return false end
  end
  return true
end

local function build_puzzle(def)
  local radius, filled = parse_solution(def.name, def.solution)
  local cells, by_key = {}, {}
  for q = -radius, radius do
    for r = math.max(-radius, -q - radius), math.min(radius, -q + radius) do
      local cell = { q = q, r = r, solution = filled[q .. "," .. r] or false, mark = BLANK }
      cells[#cells + 1] = cell
      by_key[q .. "," .. r] = cell
    end
  end
  local lines = {}
  for ai, axis in ipairs(AXES) do
    for v = -radius, radius do
      local line = { axis = ai, cells = {} }
      for _, c in ipairs(cells) do
        if line_value(ai, c.q, c.r) == v then table.insert(line.cells, c) end
      end
      table.sort(line.cells, function(a, b)
        return a.q * axis.step[1] + a.r * axis.step[2] > b.q * axis.step[1] + b.r * axis.step[2]
      end)
      line.clue = runs_of(line.cells, function(c) return c.solution end)
      lines[#lines + 1] = line
    end
  end
  return {
    name = def.name, radius = radius, cells = cells, by_key = by_key, lines = lines,
    size = nil, time = 0, started = false, solved = false, solved_time = nil,
  }
end

local function hex_to_px(size, q, r)
  return size * SQRT3 * (q + r / 2), size * 1.5 * r
end

local function px_to_hex(size, x, y)
  local fq = (SQRT3 / 3 * x - 1 / 3 * y) / size
  local fr = (2 / 3 * y) / size
  local fs = -fq - fr
  local q, r, s = math.floor(fq + 0.5), math.floor(fr + 0.5), math.floor(fs + 0.5)
  local dq, dr, ds = math.abs(q - fq), math.abs(r - fr), math.abs(s - fs)
  if dq > dr and dq > ds then
    q = -r - s
  elseif dr > ds then
    r = -q - s
  end
  return q, r
end

local function clue_texts(clue)
  if #clue == 0 then return { "0" } end
  local t = {}
  for i, n in ipairs(clue) do t[i] = tostring(n) end
  return t
end

-- Lays out Cells and Clue labels at `size`; returns the view (offset + whether it fits).
local function layout(p, size)
  local minx, miny, maxx, maxy = math.huge, math.huge, -math.huge, -math.huge
  local function grow(x0, y0, x1, y1)
    minx, miny = math.min(minx, x0), math.min(miny, y0)
    maxx, maxy = math.max(maxx, x1), math.max(maxy, y1)
  end
  for _, c in ipairs(p.cells) do
    c.x, c.y = hex_to_px(size, c.q, c.r)
    grow(c.x - size, c.y - size, c.x + size, c.y + size)
  end
  for _, line in ipairs(p.lines) do
    local axis = AXES[line.axis]
    local sx, sy = hex_to_px(1, axis.step[1], axis.step[2])
    local len = math.sqrt(sx * sx + sy * sy)
    local ux, uy = sx / len, sy / len
    local ex, ey = line.cells[1].x, line.cells[1].y
    local texts = clue_texts(line.clue)
    line.labels = {}
    for i, t in ipairs(texts) do
      local d = size + 4 + (#texts - i) * STEP
      local w, h = usagi.measure_text(t)
      local l = { text = t, x = ex + ux * d - w / 2, y = ey + uy * d - h / 2 }
      line.labels[i] = l
      grow(l.x, l.y + 2, l.x + w, l.y + 9)
    end
  end
  local avail_h = usagi.GAME_H - HUD_H
  return {
    size = size,
    ox = math.floor((usagi.GAME_W - (maxx - minx)) / 2 - minx + 0.5),
    oy = math.floor(HUD_H + (avail_h - (maxy - miny)) / 2 - miny + 0.5),
    fits = (maxx - minx) <= usagi.GAME_W and (maxy - miny) <= avail_h,
  }
end

-- Largest Cell size (up to MAX_SIZE) at which the Board and every Clue fit.
local function fit_size(p)
  for size = MAX_SIZE, 6, -1 do
    if layout(p, size).fits then return size end
  end
  return 6
end

local function current() return State.puzzles[State.index] end

local function update_satisfied(p)
  local all = true
  for _, line in ipairs(p.lines) do
    line.satisfied = same(line.clue, runs_of(line.cells, function(c) return c.mark == FILLED end))
    all = all and line.satisfied
  end
  if all and not p.solved then p.solved_time = p.time end
  p.solved = all
end

-- Auto-Crosses are derived, never stored as player intent: clear them all, then re-Cross
-- every Blank Cell on a Satisfied Line. Manual Crosses (auto = false) are never touched.
local function auto_cross(p)
  for _, c in ipairs(p.cells) do
    if c.auto then c.mark, c.auto = BLANK, false end
  end
  update_satisfied(p)
  for _, line in ipairs(p.lines) do
    if line.satisfied then
      for _, c in ipairs(line.cells) do
        if c.mark == BLANK then c.mark, c.auto = CROSSED, true end
      end
    end
  end
end

local function hovered_cell(view)
  if not input.mouse_over() then return nil end
  local mx, my = input.mouse()
  local q, r = px_to_hex(view.size, mx - view.ox, my - view.oy)
  return current().by_key[q .. "," .. r]
end

local function switch_puzzle(delta)
  State.index = (State.index - 1 + delta) % #State.puzzles + 1
  State.paint = nil
end

local function clear_puzzle(p)
  for _, c in ipairs(p.cells) do c.mark, c.auto = BLANK, false end
  p.time, p.started, p.solved_time = 0, false, nil
  auto_cross(p)
end

function _init()
  State = { index = 1, puzzles = {}, paint = nil }
  for i, def in ipairs(PUZZLES) do
    local p = build_puzzle(def)
    p.size = fit_size(p)
    State.puzzles[i] = p
    auto_cross(p)
  end
  usagi.clear_menu_items()
  usagi.menu_item("Next Puzzle", function() switch_puzzle(1) end)
  usagi.menu_item("Previous Puzzle", function() switch_puzzle(-1) end)
  usagi.menu_item("Clear this Puzzle", function() clear_puzzle(current()) end)
end

function _update(dt)
  if input.key_pressed(input.KEY_RIGHT) then switch_puzzle(1) end
  if input.key_pressed(input.KEY_LEFT) then switch_puzzle(-1) end
  local p = current()
  if input.key_pressed(input.KEY_BACKSPACE) then clear_puzzle(p) end

  local cell = hovered_cell(layout(p, p.size))
  for _, b in ipairs({ input.MOUSE_LEFT, input.MOUSE_RIGHT }) do
    if cell and input.mouse_pressed(b) then
      local want = b == input.MOUSE_LEFT and FILLED or CROSSED
      -- Right-clicking an Auto-Cross adopts it as a manual Cross rather than blanking it.
      local toggle_off = cell.mark == want and not cell.auto
      State.paint = { button = b, mark = toggle_off and BLANK or want }
    end
  end
  if State.paint then
    if input.mouse_held(State.paint.button) then
      if cell and (cell.mark ~= State.paint.mark or cell.auto) then
        cell.mark, cell.auto = State.paint.mark, false
        p.started = true
      end
    else
      State.paint = nil
    end
  end
  auto_cross(p)
  if p.started and not p.solved then p.time = p.time + dt end
end

local function hex_points(cx, cy, rad)
  local pts = {}
  for i = 0, 5 do
    local a = math.pi / 6 + i * math.pi / 3
    pts[#pts + 1] = { cx + rad * math.cos(a), cy + rad * math.sin(a) }
  end
  return pts
end

local function fill_hex(cx, cy, rad, color)
  local p = hex_points(cx, cy, rad)
  for i = 2, 5 do
    gfx.tri_fill(p[1][1], p[1][2], p[i][1], p[i][2], p[i + 1][1], p[i + 1][2], color)
  end
end

local function outline_hex(cx, cy, rad, color)
  local p = hex_points(cx, cy, rad)
  for i = 1, 6 do
    local j = i % 6 + 1
    gfx.line(p[i][1], p[i][2], p[j][1], p[j][2], color)
  end
end

local function draw_board(p, view, hover)
  local ox, oy, size = view.ox, view.oy, view.size
  -- The hovered Cell's three Lines are "hot": outlined in orange, their Clues highlighted.
  local hot, hot_cell = {}, {}
  if hover then
    for _, line in ipairs(p.lines) do
      for _, c in ipairs(line.cells) do
        if c == hover then hot[line] = true end
      end
    end
    for line in pairs(hot) do
      for _, c in ipairs(line.cells) do hot_cell[c] = true end
    end
  end
  for _, c in ipairs(p.cells) do
    local x, y = ox + c.x, oy + c.y
    fill_hex(x, y, size - 1, c.mark == FILLED and gfx.COLOR_WHITE or gfx.COLOR_DARK_BLUE)
    if c.mark == CROSSED then
      local k = size * 0.35
      local alpha = c.auto and 0.35 or 0.8
      gfx.line(x - k, y - k, x + k, y + k, gfx.COLOR_LIGHT_GRAY, alpha)
      gfx.line(x - k, y + k, x + k, y - k, gfx.COLOR_LIGHT_GRAY, alpha)
    end
  end
  for c in pairs(hot_cell) do
    outline_hex(ox + c.x, oy + c.y, size - 2, gfx.COLOR_ORANGE)
  end
  if hover then
    for inset = 1, 3 do
      outline_hex(ox + hover.x, oy + hover.y, size - inset, gfx.COLOR_ORANGE)
    end
  end
  for _, line in ipairs(p.lines) do
    local color = gfx.COLOR_WHITE
    if line.satisfied then
      color = hot[line] and gfx.COLOR_BROWN or gfx.COLOR_DARK_GRAY
    elseif hot[line] then
      color = gfx.COLOR_YELLOW
    end
    for _, l in ipairs(line.labels) do
      gfx.text(l.text, math.floor(ox + l.x + 0.5), math.floor(oy + l.y + 0.5), color)
    end
  end
end

local function fmt_time(t)
  return string.format("%d:%02d", math.floor(t / 60), math.floor(t % 60))
end

local function draw_hud(p)
  local done = 0
  for _, line in ipairs(p.lines) do
    if line.satisfied then done = done + 1 end
  end
  gfx.text(string.format("%d/%d  %s", State.index, #State.puzzles, p.name), 2, -1, gfx.COLOR_LIGHT_GRAY)
  local right = string.format("Clues %d/%d   %s", done, #p.lines, fmt_time(p.solved_time or p.time))
  local w = usagi.measure_text(right)
  gfx.text(right, usagi.GAME_W - w - 2, -1, gfx.COLOR_LIGHT_GRAY)
  local hint = "LMB Fill  RMB Cross  Left/Right Puzzle  Bksp clear"
  local hw = usagi.measure_text(hint)
  gfx.text(hint, usagi.GAME_W - hw - 2, usagi.GAME_H - 11, gfx.COLOR_DARK_GRAY)
end

function _draw(dt)
  gfx.clear(gfx.COLOR_BLACK)
  local p = current()
  local view = layout(p, p.size)
  draw_board(p, view, hovered_cell(view))
  if p.solved then
    local label = "SOLVED  " .. fmt_time(p.solved_time or p.time)
    local w = usagi.measure_text(label)
    gfx.rect_fill((usagi.GAME_W - w) / 2 - 3, HUD_H + 2, w + 6, 12, gfx.COLOR_DARK_GREEN)
    gfx.text(label, (usagi.GAME_W - w) / 2, HUD_H + 2, gfx.COLOR_WHITE)
  end
  draw_hud(p)
end
