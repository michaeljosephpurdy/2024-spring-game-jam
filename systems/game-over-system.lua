local GameOverSystem = tiny.processingSystem()
GameOverSystem.filter = tiny.requireAll('game_over')

function GameOverSystem:process(e, dt)
  if love.keyboard.isDown('space') then
    self.world:clearEntities()
    self.world:addEntity(Player(e.endless))
  elseif love.keyboard.isDown('escape') then
    self.world:clearEntities()
    self.world:addEntity(LevelSelectionTriggerEvent())
  end
end

return GameOverSystem
