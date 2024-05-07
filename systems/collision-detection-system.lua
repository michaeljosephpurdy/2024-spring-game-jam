local CollisionDetectionSystem = tiny.processingSystem()
CollisionDetectionSystem.filter = tiny.requireAll('collisions_enabled', 'x', 'y')

function CollisionDetectionSystem:initialize(props)
  self.bump_world = props.bump_world
end

local function collision_filter(e1, e2)
  if not e1.class or not e2.class then
    return 'cross'
  end
  local player = e1 --[[@as Player]]

  if e2.class == SolidPlatform then
    return 'slide'
  end

  if e2.class == SideCheckingGate then
    local other = e2 --[[@as SideCheckingGate]]
    if other.sides == player.sides then
      return 'cross'
    else
      return 'slide'
    end
  end

  --return 'slide'
end

function CollisionDetectionSystem:process(e, dt)
  local cols, len
  local future_x = e.x + (e.velocity_x * dt)
  local future_y = e.y + (e.velocity_y * dt)
  e.x, e.y, cols, len = self.bump_world:move(e, future_x, future_y, collision_filter)
  e.on_ground = false
  for i = 1, len do
    local col = cols[i]
    local collided = true
    if col.type == 'touch' then
      e.velocity_x, e.velocity_y = 0, 0
    elseif col.type == 'slide' then
      if col.normal.x == 0 then
        e.velocity_y = 0
        if col.normal.y < 0 then
          e.on_ground = true
        end
      else
        e.velocity_x = 0
      end
    elseif col.type == 'onewayplatform' then
      if col.did_touch then
        e.velocity_y = 0
        e.on_ground = true
      else
        collided = false
      end
    elseif col.type == 'onewayplatformTouch' then
      if col.did_touch then
        e.velocity_y = 0
        e.on_ground = true
      else
        collided = false
      end
    elseif col.type == 'bounce' then
      if col.normal.x == 0 then
        e.velocity_y = -e.velocity_y
        e.on_ground = true
      else
        e.velocity_x = -e.velocity_x
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
