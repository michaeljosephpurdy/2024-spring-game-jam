local SpriteDrawingSystem = tiny.processingSystem()
SpriteDrawingSystem.filter = tiny.requireAll('sprite', 'x', 'y')
SpriteDrawingSystem.is_draw_system = true

function SpriteDrawingSystem:onAdd(e) end

function SpriteDrawingSystem:process(e, dt)
  love.graphics.draw(e.sprite, e.x, e.y)
end

return SpriteDrawingSystem
