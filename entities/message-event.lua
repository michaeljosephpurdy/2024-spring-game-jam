local MessageEvent = class('MessageEvent')

function MessageEvent:initialize(message, time_to_live)
  self.message = message
  self.time_to_live = time_to_live or 1
end

return MessageEvent
