---@class Player
---@field new function
---@field controllable boolean
---@field camera_follow boolean
---@field verticies table
---@field angle number
---@field last_action PlayerActions
local Player = class('Player')

---@enum PlayerActions
local PlayerActions = {
  NONE = 'NONE',
  FLIP = 'FLIP',
  DECREMENT = 'DECREMENT',
  INCREMENT = 'INCREMENT',
}

local SIDES = {
  nil, --1
  nil, --2
  { 0, 100, 100, 100, 50, 0 }, -- triangle
  { 0, 0, 100, 0, 100, 100, 0, 100 }, -- rectangle
  { 0, 50, 50, 0, 100, 50, 66, 100, 33, 100 }, -- pentagon
  { 25, 0, 75, 0, 100, 50, 75, 100, 25, 100, 0, 50 }, -- hexagon
  { 50, 0, 80, 20, 100, 60, 75, 100, 25, 100, 0, 60, 20, 20 }, --heptagon
  { 25, 0, 75, 0, 100, 25, 100, 75, 75, 100, 25, 100, 0, 75, 0, 25 }, --octagon
}
local LOWER_SIDE_LIMIT = 3
local UPPER_SIDE_LIMIT = #SIDES

function Player:initialize()
  self.x, self.y = 40, 40
  self.controllable = true
  self.camera_follow = true
  self.sides = 3
  self.verticies = SIDES[self.sides]
  self.angle = 0
end

---@private
---@param action PlayerActions
function Player:set_action(action)
  self.last_action = action
end

--- resets users input, allowing
--- non-repeatable actions to be taken again.
--- major point is to act like a debounce, to ensure
--- that players don't spam the buttons by holding
--- them down, but also to ensure they don't
--- accidentally overshoot their desired shape count
function Player:reset_input()
  self:set_action('NONE')
end

--- flips gravity, but only if user didn't just flip it
function Player:flip()
  if self.last_action == 'FLIP' then
    return
  end
  self.last_action = 'FLIP'
  -- flip gravity
end

--- decrements count of sides
--- if user didn't just take that action
function Player:decrement_sides()
  if self.last_action == 'DECREMENT' then
    return
  end
  self.last_action = 'DECREMENT'
  self.sides = self.sides - 1
  if self.sides < LOWER_SIDE_LIMIT then
    self.sides = LOWER_SIDE_LIMIT
  end
  self.verticies = SIDES[self.sides]
end

--- increments count of side
--- if user didn't just take that action
function Player:increment_sides()
  if self.last_action == 'INCREMENT' then
    return
  end
  self.last_action = 'INCREMENT'
  self.sides = self.sides + 1
  if self.sides > UPPER_SIDE_LIMIT then
    self.sides = UPPER_SIDE_LIMIT
  end
  self.verticies = SIDES[self.sides]
end

return Player
