local BackgroundSpriteDrawingSystem = tiny.processingSystem()
BackgroundSpriteDrawingSystem.filter = tiny.requireAll('draw_background', 'sprite', 'x', 'y')
BackgroundSpriteDrawingSystem.is_draw_system = true

function BackgroundSpriteDrawingSystem:process(e, dt)
  love.graphics.draw(e.sprite, e.x, e.y)
end

return BackgroundSpriteDrawingSystem
