local PlayerInputSystem = tiny.processingSystem()
PlayerInputSystem.filter = tiny.requireAll('controllable')
PlayerInputSystem.is_update_system = true

--- Controls player input.
--- Players can either hit left, right, or both
---@param player Player
---@param dt number
function PlayerInputSystem:process(player, dt)
  local up = love.keyboard.isDown('up') or love.keyboard.isDown('w')
  local down = love.keyboard.isDown('down') or love.keyboard.isDown('s')
  local left = love.keyboard.isDown('left') or love.keyboard.isDown('a') or love.keyboard.isDown('z')
  local right = love.keyboard.isDown('right') or love.keyboard.isDown('d') or love.keyboard.isDown('x')

  if up then
    local jumped = player:jump()
    if jumped then
      self.world:addEntity(Audio('jump'))
      self.world:addEntity(Particle(player.x, player.y, 0, 'Jump'))
      self.world:addEntity(Particle(player.x, player.y, 0, 'Jump'))
      self.world:addEntity(Particle(player.x, player.y, 0, 'Jump'))
      self.world:addEntity(Particle(player.x, player.y, 0, 'Jump'))
      self.world:addEntity(Particle(player.x, player.y, 0, 'Jump'))
    end
    return
  end

  if down then
    if player:flip() then
      self.world:addEntity(FlipGravityEvent())
      self.world:addEntity(Audio('flip'))
      return
    else
      return
    end
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
