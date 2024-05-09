---@class Level
--- Spelunky had an interesting way of procedurally generating levels.
--- Derek Yu and the team would create a selection of pre-fabricated chunks
--- and then use those (at random/weighted random) to generate the overall level.
--- This offerred a lot of replayability, while keeping overall quality where they wanted it to be.
---
--- I am very biased towards using LDtk for level generation, but I think this time I may take
--- a more simple approach.
---@field x number
---@field y number
---@field variant LevelVariant
local Level = class('Level')
Level.is_level = true

---@class LevelVariant
---@field map string[]
local LevelVariant

---@type LevelVariant[]
-- stylua: ignore start
local POSSIBLE_VARIANTS = {{
 map={'XXXXXXXXXXXXXX',
      ' >    *   #   ',
      '              ',
      '              ',
      '              ',
      '              ',
      '              ',
      '     3  >     ',
      'XXXXXXXXXXXXXX'},
 },{
 map={'XXXXXXXXXXXXXX',
      '              ',
      '              ',
      '              ',
      '              ',
      '              ',
      '     X        ',
      '     4        ',
      'XXXXXXXXXXXXXX'},
 },
}
-- stylua: ignore end

function Level:initialize(x, y)
  self.x = x or 0
  self.y = y or 0
  local variant_index = love.math.random(1, #POSSIBLE_VARIANTS)
  self.variant = POSSIBLE_VARIANTS[variant_index]
  self.width = #self.variant.map[1] * 32
  self.height = #self.variant.map * 32
  self.move_left = true
  self:parse_map()
end

---@private
function Level:parse_map()
  ---@private
  self.level_contents = {}
  for row, rows in ipairs(self.variant.map) do
    for col = 1, #rows do
      local value = rows:sub(col, col)
      local x = (col * 32) + self.x
      local y = (row * 32) + self.y
      if value == 'X' then
        table.insert(self.level_contents, SolidPlatform(x, y))
      elseif value == '*' then
        --table.insert(self.level_contents, Spike(x, y))
      elseif value == '>' then
        table.insert(self.level_contents, SpeedUpGate(x, y))
      elseif value == '#' then
        table.insert(self.level_contents, SideCheckingGate(x, y))
      elseif tonumber(value) then
        table.insert(self.level_contents, SideCheckingGate(x, y, tonumber(value)))
      end
    end
  end
end

---@return table[] bunch of data that level spawner will use to create
---colliders, polygons (to be rendered), etc.
function Level:get_contents()
  return self.level_contents
end

return Level
