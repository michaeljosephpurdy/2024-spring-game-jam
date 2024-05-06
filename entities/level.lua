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
 map={'         ',
      '         ',
      '     4   ',
      'XXXXXXXXX'},
 },{
 map={'XXXXXXXXX',
      '         ',
      '         ',
      '         '},
 },
}
-- stylua: ignore end

local SolidPlatform = require('entities.solid-platform')
local SideCheckingGate = require('entities.side-checking-gate')

function Level:initialize(x, y)
  self.x = x or 0
  self.y = y or 0
  self.variant = POSSIBLE_VARIANTS[1]
  self.width = 9 * 100
  self.height = 4 * 100
  ---@private
  self.level_contents = {}
  -- parse map
  for row, rows in ipairs(self.variant.map) do
    for col = 1, #rows do
      local value = rows:sub(col, col)
      if value == 'X' then
        table.insert(self.level_contents, SolidPlatform:new(col * 100, row * 100))
      elseif tonumber(value) then
        table.insert(self.level_contents, SideCheckingGate:new(col * 100, row * 100, tonumber(value)))
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
