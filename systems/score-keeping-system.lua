local ScoreKeepingSystem = tiny.processingSystem()
ScoreKeepingSystem.filter = tiny.requireAll('is_player')

---@param player Player
---@return integer
local function calculate_score(player)
  return math.floor(player.x / 100)
end

function ScoreKeepingSystem:process(e, dt)
  local score = tostring(calculate_score(e))
  self.world:addEntity(MessageEvent('score: ' .. tostring(score), 0, GAME_WIDTH / 8, GAME_HEIGHT / 8))
end

function ScoreKeepingSystem:onRemove(e)
  local score = tostring(calculate_score(e))
  self.world:addEntity(MessageEvent('score: ' .. tostring(score), 10, GAME_WIDTH / 2, GAME_HEIGHT / 4))
end

return ScoreKeepingSystem
