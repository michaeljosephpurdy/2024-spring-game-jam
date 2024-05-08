local DebugOverlaySystem = tiny.processingSystem()
DebugOverlaySystem.filter = tiny.requireAll('x', 'y')
DebugOverlaySystem.is_draw_system = true

function DebugOverlaySystem:process(e, dt)
  if e.class == SolidPlatform then
    return
  end
  local x, y = e.x, e.y
  local y_buffer = 48
  love.graphics.push()
  love.graphics.print('x: ' .. x, x, y - y_buffer)
  love.graphics.print('y: ' .. y, x, y - y_buffer + 8)
  love.graphics.print('velocity_x: ' .. tostring(e.velocity_x), x, y - y_buffer + 16)
  love.graphics.print('velocity_y: ' .. tostring(e.velocity_y), x, y - y_buffer + 24)
  love.graphics.print('is_on_ground: ' .. tostring(e.is_on_ground), x, y - y_buffer + 32)

  if e.hitbox then
    love.graphics.rectangle('line', e.x, e.y, e.hitbox.width, e.hitbox.height)
  end
  love.graphics.pop()
end

return DebugOverlaySystem
