HorizontalMovementSystem = tiny.processingSystem()
HorizontalMovementSystem.filter = tiny.requireAll('x', 'move_left')

function HorizontalMovementSystem:process(e, dt)
  e.velocity_x = -100
end

return HorizontalMovementSystem
