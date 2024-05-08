local EntityCleanupSystem = tiny.processingSystem()
EntityCleanupSystem.filter = tiny.requireAll('x')

function EntityCleanupSystem:process(e, dt)
  if e.x > -300 then
    return
  end
  self.world:removeEntity(e)
end

return EntityCleanupSystem
