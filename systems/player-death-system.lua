local PlayerDeathSystem = tiny.processingSystem()
PlayerDeathSystem.filter = tiny.requireAll('is_player')

function PlayerDeathSystem:initialize(props)
  self.top_dead_limit = -GAME_HEIGHT
  self.bottom_dead_limit = GAME_HEIGHT * 2
  self.left_dead_limit = -GAME_WIDTH
end

---@param player Player
---@param dt number
function PlayerDeathSystem:process(player, dt)
  local past_top = player.y < self.top_dead_limit
  local past_bottom = player.y > self.bottom_dead_limit
  local past_left = player.x < self.left_dead_limit
  if past_top or past_bottom or past_left then
    self.world:remove(player)
  end
end

return PlayerDeathSystem
