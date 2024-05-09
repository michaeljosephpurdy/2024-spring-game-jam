local GameOverEvent = class('GameOverEvent')
GameOverEvent.is_event = true

function GameOverEvent:initialize()
  self.game_over = true
end

return GameOverEvent
