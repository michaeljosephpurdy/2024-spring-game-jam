local SpriteDrawingSystem = tiny.processingSystem()
local rejection_filter = tiny.rejectAny('draw_foreground', 'draw_background')
SpriteDrawingSystem.filter = tiny.requireAll(rejection_filter, 'sprite', 'x', 'y')
SpriteDrawingSystem.is_draw_system = true

function SpriteDrawingSystem:process(e, dt)
  love.graphics.draw(e.sprite, e.x, e.y)
end

return SpriteDrawingSystem
