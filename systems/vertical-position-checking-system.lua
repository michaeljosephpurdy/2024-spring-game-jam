local VerticalPositionCheckingSystem = tiny.processingSystem()
VerticalPositionCheckingSystem.filter = tiny.requireAll('is_player', 'y')

function VerticalPositionCheckingSystem:process(e, dt)
  if e.y < -100 or e.y > GAME_HEIGHT + 100 then
    self.world:addEntity(MessageEvent('            YOU DIED\nPRESS spacebar TO RETRY\nPRESS escape FOR MENU', 999))
    self.world:removeEntity(e)
    self.world:addEntity(GameOverEvent())
  end
end

return VerticalPositionCheckingSystem
