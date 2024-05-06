local PlayerMovementSystem = tiny.processingSystem()
PlayerMovementSystem = tiny.requireAll('controllable')

function PlayerMovementSystem:process(e, dt) end

return PlayerMovementSystem
