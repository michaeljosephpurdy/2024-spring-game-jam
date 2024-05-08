---@enum ParticleType
local ParticleType = {
  PLAYER = 'PLAYER',
}

---@class ParticleData
local ParticleData = {}

---@type {[ParticleType]: ParticleData}
local ParticleTypeToData = {
  [ParticleType.PLAYER] = {},
}

---@class Particle
---@field type ParticleType
local Particle = class('Particle') --[[@as Particle]]

---@param x number
---@param y number
---@param type ParticleType
function Particle:initialize(x, y, type)
  self.x, self.y = x, y
  local data = ParticleTypeToData[type]
  if not data then
  end
  for k, v in pairs(data) do
    self[k] = v
  end
end

return Particle
