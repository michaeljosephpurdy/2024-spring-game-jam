local GravitySystem = tiny.processingSystem()
GravitySystem.filter = tiny.requireAll('y', 'is_affected_by_gravity')

function GravitySystem:initialize(props)
  self.gravity = GRAVITY
  self.max_velocity = MAX_GRAVITY
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
  if self.gravity_direction == 1 and e.velocity_y > self.max_velocity then
    e.velocity_y = self.max_velocity
  elseif self.gravity_direction == -1 and e.velocity_y < -self.max_velocity then
    e.velocity_y = -self.max_velocity
  end
  e.gravity_direction = self.gravity_direction
end

return GravitySystem
