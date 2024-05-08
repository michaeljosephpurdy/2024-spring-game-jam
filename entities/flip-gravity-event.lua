---@class FlipGravityEvent
---@field y number useless value to be picked up by gravity system
---@field is_affected_by_gravity boolean useless value to be picked up by gravity system
---@field is_event boolean used to signal one time processing
local FlipGravityEvent = class('FlipGravityEvent')

function FlipGravityEvent:initialize()
  -- dummy values to be picked up by gravity system
  self.y = 0
  self.is_affected_by_gravity = true
  self.is_event = true
end

return FlipGravityEvent
