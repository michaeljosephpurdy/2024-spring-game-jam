local CollisionDetectionSystem = tiny.processingSystem()
CollisionDetectionSystem.filter = tiny.requireAll('collision_detection_enabled', 'x', 'y')

function CollisionDetectionSystem:initialize(props)
  self.bump_world = props.bump_world
end

local function collision_filter(e1, e2)
  if e1.class ~= Player then
    return 'cross'
  end

  local player = e1 --[[@as Player]]

  if e2.class == SolidPlatform then
    return 'slide'
  end

  if e2.class == SideCheckingGate then
    local other = e2 --[[@as SideCheckingGate]]
    if other.crossed then
      return 'cross'
    end
    if other.sides == player.sides then
      return 'cross'
    else
      return 'slide'
    end
  end

  return 'cross'
end

function CollisionDetectionSystem:process(e, dt)
  local cols, len
  local future_x = e.x + (e.velocity_x * dt)
  local future_y = e.y + (e.velocity_y * dt)
  e.x, e.y, cols, len = self.bump_world:move(e, future_x, future_y, collision_filter)
  e.is_on_ground = false
  for i = 1, len do
    local col = cols[i]
    local collided = true
    if e.class == EntityKiller and col.type == 'cross' then
      self.world:removeEntity(col.other)
      local particle_count = col.other.particle_count or 3
      for _ = 0, particle_count do
        self.world:addEntity(Particle(col.other.x, col.other.y, col.other.gravity_direction, col.other.class.name))
      end
    end
    -- any other entity below this will be player
    if col.other.crossed then
      return
    end

    if col.type == 'cross' then
      col.other.crossed = true
      if col.other.class == SpeedUpGate then
        self.world:addEntity(SpeedupEvent())
      end
    elseif col.type == 'touch' then
      e.velocity_x, e.velocity_y = 0, 0
    elseif col.type == 'slide' then
      if col.normal.x == 0 then
        e.velocity_y = 0
        if e.gravity_direction > 0 and col.normal.y < 0 then
          e.is_on_ground = true
        elseif e.gravity_direction < 0 and col.normal.y > 0 then
          e.is_on_ground = true
        end
      else
        e.velocity_x = 0
      end
    end
    if e.on_collision and collided then
      e:on_collision(col)
    end
    if col.other and col.other.on_collision and collided then
      col.other:on_collision(e)
    end
  end
end

return CollisionDetectionSystem
