local SpeedupGate = class('SpeedupGate')

local SPRITE = love.graphics.newImage('assets/speedup-gate.png')

function SpeedupGate:initialize(x, y)
  self.x, self.y = x, y
  self.hitbox = { width = 32, height = 32 }
  self.sprite = SPRITE
end

return SpeedupGate
