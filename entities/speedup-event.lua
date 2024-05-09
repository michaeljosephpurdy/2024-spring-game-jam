---@class SpeedupEvent
---@field time_to_live number
---@field value number
local SpeedupEvent = class('SpeedupEvent')
SpeedupEvent.is_event = true

function SpeedupEvent:initialize(value, time_to_live)
  self.value = value or 20
  self.time_to_live = time_to_live or 0.5
  self.speedup = true
end

return SpeedupEvent
