local EntityCleanupSystem = tiny.processingSystem()
EntityCleanupSystem.filter = tiny.requireAll('x')

function EntityCleanupSystem:initialize(props)
  self.bump_world = props.bump_world
  self.tiny_world = props.tiny_world
end

function EntityCleanupSystem:process(e, dt)
  if e.x > -300 then
    return
  end
  self.tiny_world:removeEntity(e)
end

return EntityCleanupSystem
