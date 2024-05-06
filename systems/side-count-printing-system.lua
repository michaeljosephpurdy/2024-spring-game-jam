local SideCountPrintingSystem = tiny.processingSystem()
SideCountPrintingSystem.filter = tiny.requireAll('sides', 'x', 'y')
SideCountPrintingSystem.is_draw_system = true

function SideCountPrintingSystem:process(e, dt)
  love.graphics.print(tostring(e.sides), e.x, e.y)
end

return SideCountPrintingSystem
