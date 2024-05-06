---@class SolidPlatform
--- These platforms are used as primary collider with player
--- and are to act as the floor/ceiling/walls of the game.
--- If there is a platform in the way of the player,
--- and they do not jump over it, or flip to potential ceiling, then
--- they should be pushed by the platform
---@field x number
---@field y number
---@field hitbox Hitbox
---@field verticies table
local SolidPlatform = class('SolidPlatform')

function SolidPlatform:initialize(x, y)
  self.x, self.y = x, y
  self.hitbox = { width = 100, height = 100 }
  self.verticies = { 0, 0, 100, 0, 100, 100, 0, 100 }
end

return SolidPlatform
