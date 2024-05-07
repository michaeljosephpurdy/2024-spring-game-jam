local GravitySystem = tiny.processingSystem()
GravitySystem.filter = tiny.requireAll('y', 'is_affected_by_gravity')

function GravitySystem:initialize(props)
  self.gravity = 100
  PubSub.subscribe('flip_gravity', function()
    self.gravity = self.gravity * -1
  end)
end

function GravitySystem:process(e, dt)
  local new_velocity = e.velocity_y or 0
  e.velocity_y = new_velocity + self.gravity
end

return GravitySystem
