local LevelSpawningSystem = tiny.processingSystem()
LevelSpawningSystem.filter = tiny.requireAll('is_player')

function LevelSpawningSystem:onAdd(player)
  self.level_one = self:next_level(player)
  self.level_two = self:next_level(self.level_one)
end

function LevelSpawningSystem:next_level(current_level)
  local x = 0
  if current_level then
    x = current_level.x + (current_level.width or 0)
  end
  local level = Level(x)
  local level_contents = level:get_contents()
  for _, entity in ipairs(level_contents) do
    self.world:addEntity(entity)
  end
  return level
end

function LevelSpawningSystem:process(e, dt)
  if e.x > self.level_one.x + self.level_one.width then
    self.level_one = self:next_level(self.level_two)
  end
  if e.x > self.level_two.x + self.level_two.width then
    self.level_two = self:next_level(self.level_one)
  end
end

return LevelSpawningSystem
