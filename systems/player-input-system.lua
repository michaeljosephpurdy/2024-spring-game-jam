local PlayerInputSystem = tiny.processingSystem()
PlayerInputSystem.filter = tiny.requireAll('controllable')
PlayerInputSystem.is_update_system = true

--- Controls player input.
--- Players can either hit left, right, or both
---@param player Player
---@param dt number
function PlayerInputSystem:process(player, dt)
  local right = love.keyboard.isDown('right') or love.keyboard.isDown('x')
  local left = love.keyboard.isDown('left') or love.keyboard.isDown('z')
  local both = left and right

  if both then
    player:flip()
    return
  end

  if left then
    player:decrement_sides()
    return
  end

  if right then
    player:increment_sides()
    return
  end

  player:reset_input()
end

return PlayerInputSystem
