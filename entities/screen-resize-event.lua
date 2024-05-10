local ScreenResizeEvent = class('ScreenResizeEvent')
ScreenResizeEvent.is_event = true
ScreenResizeEvent.resize = true

function ScreenResizeEvent:initialize(width, height)
  self.width, self.height = width, height
end

return ScreenResizeEvent
