RightMovementSystem = tiny.processingSystem()
RightMovementSystem.filter = tiny.requireAll('x', 'move_right')

function RightMovementSystem:process(e, dt)
  e.velocity_x = 100
end

return RightMovementSystem
