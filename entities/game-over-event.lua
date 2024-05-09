local GameOverEvent = class('GameOverEvent')
GameOverEvent.is_event = true

function GameOverEvent:initialize(endless)
  self.game_over = true
  self.endless = endless
end

return GameOverEvent
