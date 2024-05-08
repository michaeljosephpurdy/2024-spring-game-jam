local ForegroundSpriteDrawingSystem = tiny.processingSystem()
ForegroundSpriteDrawingSystem.filter = tiny.requireAll('draw_foreground', 'sprite', 'x', 'y')
ForegroundSpriteDrawingSystem.is_draw_system = true

function ForegroundSpriteDrawingSystem:process(e, dt)
  love.graphics.draw(e.sprite, e.x, e.y)
end

return ForegroundSpriteDrawingSystem
