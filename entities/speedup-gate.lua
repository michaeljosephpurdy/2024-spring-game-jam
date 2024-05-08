local SpeedupGate = class('SpeedupGate')

local SPRITE = love.graphics.newImage('assets/gate-speedup.png')

function SpeedupGate:initialize(x, y)
  self.x, self.y = x, y
  self.hitbox = { width = 40, height = 40 }
  self.sprite = SPRITE
end

return SpeedupGate
