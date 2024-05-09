local MessageOverlaySystem = tiny.processingSystem()
MessageOverlaySystem.is_draw_system = true
MessageOverlaySystem.filter = tiny.requireAll('message')

function drawCenteredText(x, y, width, height, text)
  local font = love.graphics.getFont()
  local text_width = font:getWidth(text)
  local text_height = font:getHeight()
  love.graphics.print(text, x + width / 2, y + height / 2, 0, 1, 1, text_width / 2, text_height / 2)
end

function MessageOverlaySystem:process(e, dt)
  love.graphics.push()
  love.graphics.origin() -- Reset the state to the defaults.
  love.graphics.setColor(PALETTE.DARK)
  if e.x and e.y then
    drawCenteredText(e.x, e.y, 0, 0, e.message)
  else
    drawCenteredText(0, 0, GAME_WIDTH, GAME_HEIGHT, e.message)
  end
  love.graphics.pop()
end

return MessageOverlaySystem
