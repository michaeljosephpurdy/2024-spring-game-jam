local GravitySystem = tiny.processingSystem()
GravitySystem.filter = tiny.requireAll('y', 'is_affected_by_gravity')

function GravitySystem:initialize(props)
  self.gravity = 100
  self.gravity_direction = 1
end

function GravitySystem:onAdd(e)
  if e.is_event then
    self.gravity = self.gravity * -1
    self.gravity_direction = self.gravity_direction * -1
    self.world:removeEntity(e)
  end
end

function GravitySystem:process(e, dt)
  local new_velocity = e.velocity_y or 0
  e.velocity_y = new_velocity + self.gravity
  e.gravity_direction = self.gravity_direction
end

return GravitySystem
