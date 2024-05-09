local ScreenShakeEvent = class('ScreenShakeEvent')
ScreenShakeEvent.screen_shake = true

function ScreenShakeEvent:initialize(magnitude, duration)
  self.magnitude = magnitude
  self.time_to_live = duration or 0.3
end

return ScreenShakeEvent
