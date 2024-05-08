---@class SolidPlatform
--- These platforms are used as primary collider with player
--- and are to act as the floor/ceiling/walls of the game.
--- If there is a platform in the way of the player,
--- and they do not jump over it, or flip to potential ceiling, then
--- they should be pushed by the platform
---@field x number
---@field y number
---@field hitbox Hitbox
---@field move_left boolean
---@field is_solid boolean
local SolidPlatform = class('SolidPlatform')

local SPRITE = {
  default = love.graphics.newImage('assets/solid-platform.png'),
}

function SolidPlatform:initialize(x, y)
  self.x, self.y = x, y
  self.move_left = true
  self.hitbox = { width = 32, height = 32 }
  self.is_solid = true
  self.velocity_y = 0
  self.sprite = SPRITE.default
  self.draw_background = true
end

return SolidPlatform
