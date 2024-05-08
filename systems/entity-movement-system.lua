local EntityMovementSystem = tiny.processingSystem()
local rejection_filter = tiny.rejectAll('hitbox')
EntityMovementSystem.filter = tiny.requireAll(rejection_filter, 'x', 'y', 'velocity_x', 'velocity_y')

function EntityMovementSystem:process(e, dt)
  e.x = e.x + (e.velocity_x * dt)
  e.y = e.y + (e.velocity_y * dt)
end

return EntityMovementSystem
