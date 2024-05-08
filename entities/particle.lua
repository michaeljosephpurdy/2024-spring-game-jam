local SPRITES = {
  LIGHT = love.graphics.newImage('assets/light-piece.png'),
  DARK = love.graphics.newImage('assets/dark-piece.png'),
}

---@class ParticleData
---@field sprite table
local ParticleData = {}

---@type {[string]: ParticleData}
local ParticleTypeToData = {
  Player = {
    sprite = SPRITES.LIGHT,
    is_affected_by_gravity = true,
  },
}

---@class Particle
---@field type ParticleType
local Particle = class('Particle') --[[@as Particle]]

---@param x number
---@param y number
---@param type ParticleType
function Particle:initialize(x, y, gravity_direction, type)
  self.x, self.y = x, y
  self.sprite = SPRITES.DARK
  local data = ParticleTypeToData[type]
  if data then
    for k, v in pairs(data) do
      self[k] = v
    end
  end
  self.velocity_x = love.math.random(-400, 400)
  self.velocity_y = love.math.random(200, 400)
  self.velocity_y = self.velocity_y * (gravity_direction or -1)
  self.time_to_live = 1
end

return Particle
