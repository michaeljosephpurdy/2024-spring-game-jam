local EntityKiller = class('EntityKiller')

local SPRITE = love.graphics.newImage('assets/entity-killer.png')

function EntityKiller:initialize()
  self.x = -100
  self.y = 50
  self.velocity_y = 0
  self.move_right = true
  self.sprite = SPRITE
  self.is_killer = true
  self.hitbox = { width = 16, height = 320 }
  self.collision_detection_enabled = true
  self.camera_follow = true
end

return EntityKiller
