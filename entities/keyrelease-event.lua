local KeyReleaseEvent = class('KeyReleaseEvent')
KeyReleaseEvent.time_to_live = 0
KeyReleaseEvent.is_event = true
KeyReleaseEvent.key_release = true

function KeyReleaseEvent:initialize(keycode)
  self.keycode = keycode
end

return KeyReleaseEvent
