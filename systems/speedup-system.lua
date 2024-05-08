local SpeedupSystem = tiny.processingSystem()
SpeedupSystem.filter = tiny.requireAll('speedup')

function SpeedupSystem:onAdd(e)
  self.speedup = 0
  if e.class == SpeedupEvent then
    self.speedup = e.value
  end
end

function SpeedupSystem:process(e, dt)
  if e.class == SpeedupEvent then
    return
  end
  e.velocity_x = e.velocity_x + self.speedup
end

function SpeedupSystem:onRemove(e)
  if e.class == SpeedupEvent then
    self.speedup = 0
  end
end

return SpeedupSystem
