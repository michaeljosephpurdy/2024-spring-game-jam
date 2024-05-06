local PolygonDrawingSystem = tiny.processingSystem()
PolygonDrawingSystem.filter = tiny.requireAll('verticies', 'x', 'y')
PolygonDrawingSystem.is_draw_system = true

---Draws a polygon offset by entity's position (x, y)
---@param e table
---@param dt number
function PolygonDrawingSystem:process(e, dt)
  love.graphics.push()
  local x, y = e.x, e.y
  local verticies = {}
  for i = 1, #e.verticies, 2 do
    table.insert(verticies, e.verticies[i] + x)
    table.insert(verticies, e.verticies[i + 1] + y)
  end
  love.graphics.setLineStyle('rough')
  love.graphics.setColor(0, 1, 0)
  love.graphics.polygon('fill', verticies)
  love.graphics.pop()
end

return PolygonDrawingSystem
