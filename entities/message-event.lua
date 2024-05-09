local MessageEvent = class('MessageEvent')
MessageEvent.is_event = true

function MessageEvent:initialize(message, time_to_live, x, y)
  self.message = message
  self.time_to_live = time_to_live or 1
  self.x, self.y = x, y
end

return MessageEvent
