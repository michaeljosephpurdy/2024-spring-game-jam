---@class Player
---@field new function
---@field controllable boolean
---@field angle number
---@field last_action PlayerActions
---@field hitbox Hitbox
---@field collision_detection_enabled boolean
---@field is_player boolean
---@field is_affected_by_gravity boolean
---@field is_on_ground boolean
---@field particle_count number
---@field speedup boolean
local Player = class('Player') --[[@as Player]]

---@enum PlayerActions
local PlayerActions = {
  NONE = 'NONE',
  JUMP = 'JUMP',
  FLIP = 'FLIP',
  DECREMENT = 'DECREMENT',
  INCREMENT = 'INCREMENT',
}

local SPRITES = {
  nil, --1
  nil, --2
  love.graphics.newImage('assets/player-3.png'), -- triangle
  love.graphics.newImage('assets/player-4.png'), -- rectangle
  love.graphics.newImage('assets/player-5.png'), -- pentagon
  love.graphics.newImage('assets/player-6.png'), --- hexagon
  love.graphics.newImage('assets/player-7.png'), --heptagon
  love.graphics.newImage('assets/player-8.png'), --octagon
}
local LOWER_SIDE_LIMIT = 3
local UPPER_SIDE_LIMIT = #SPRITES

function Player:initialize()
  self.x, self.y = 40, 100
  self.velocity_x, self.velocity_y = 0, 0
  self.controllable = true
  self.sides = 3
  self.angle = 0
  self.hitbox = { width = 32, height = 32 }
  self.collision_detection_enabled = true
  self.is_affected_by_gravity = true
  self.is_player = true
  self.sprite = SPRITES[self.sides]
  self.move_right = true
  self.is_on_ground = true
  self.particle_count = self.sides
  self.gravity_direction = 1
  self.speedup = true
  self.draw_foreground = true
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
    return false
  end
  self.last_action = 'FLIP'
  return true
end

--- jumps
--- if user didn't just take that action
function Player:jump()
  if not self.is_on_ground then
    return false
  end
  self.velocity_y = self.velocity_y - 500 * self.gravity_direction
  self.last_action = 'JUMP'
  return true
end

--- decrements count of sides
--- if user didn't just take that action
function Player:decrement_sides()
  if self.last_action == 'DECREMENT' then
    return false
  end
  self.last_action = 'DECREMENT'
  self.sides = self.sides - 1
  if self.sides < LOWER_SIDE_LIMIT then
    self.sides = LOWER_SIDE_LIMIT
  end
  self.sprite = SPRITES[self.sides]
  self.particle_count = self.sides
  return true
end

--- increments count of side
--- if user didn't just take that action
function Player:increment_sides()
  if self.last_action == 'INCREMENT' then
    return false
  end
  self.last_action = 'INCREMENT'
  self.sides = self.sides + 1
  if self.sides > UPPER_SIDE_LIMIT then
    self.sides = UPPER_SIDE_LIMIT
  end
  self.sprite = SPRITES[self.sides]
  self.particle_count = self.sides
  return true
end

return Player
