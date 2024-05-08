local GameOverEvent = class('GameOverEvent')

function GameOverEvent:initialize()
  self.is_event = true
  self.game_over = true
end

return GameOverEvent
