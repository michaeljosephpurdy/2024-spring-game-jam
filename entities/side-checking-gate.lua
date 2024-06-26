---@class SideCheckingGate
---@field hitbox Hitbox
---@field crossed boolean
local SideCheckingGate = class('SideCheckingGate')

local SPRITES = {
  nil, --1
  nil, --2
  love.graphics.newImage('assets/gate-3.png'), -- triangle
  love.graphics.newImage('assets/gate-4.png'), -- rectangle
  love.graphics.newImage('assets/gate-5.png'), -- pentagon
  love.graphics.newImage('assets/gate-6.png'), --- hexagon
  love.graphics.newImage('assets/gate-7.png'), --heptagon
  love.graphics.newImage('assets/gate-8.png'), --octagon
}

function SideCheckingGate:initialize(x, y, sides)
  self.sides = sides or love.math.random(3, #SPRITES)
  local random_sprite_index = self.sides
  self.sprite = SPRITES[random_sprite_index]
  self.x, self.y = x, y
  self.move_left = true
  self.hitbox = { width = 32, height = 32 }
  self.velocity_x = 0
  self.velocity_y = 0
  self.draw_foreground = true
end

return SideCheckingGate
