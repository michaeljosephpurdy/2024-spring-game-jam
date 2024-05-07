LeftMovementSystem = tiny.processingSystem()
LeftMovementSystem.filter = tiny.requireAll('x', 'move_left')

function LeftMovementSystem:process(e, dt)
  --e.velocity_x = -100
  e.velocity_x = 0
end

return LeftMovementSystem
