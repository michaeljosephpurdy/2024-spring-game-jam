---@class FlipGravityEvent
---@field y number useless value to be picked up by gravity system
---@field is_affected_by_gravity boolean useless value to be picked up by gravity system
---@field is_event boolean used to signal one time processing
local FlipGravityEvent = class('FlipGravityEvent')
FlipGravityEvent.is_event = true

function FlipGravityEvent:initialize()
  -- dummy values to be picked up by gravity system
  self.y = 0
  self.is_affected_by_gravity = true
end

return FlipGravityEvent
