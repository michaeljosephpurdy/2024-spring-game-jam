local LevelSpawningSystem = tiny.processingSystem()
LevelSpawningSystem.filter = tiny.requireAll('is_level')

local LOWER_LEFT_BOUND = -200

function LevelSpawningSystem:initialize(props)
  self.tiny_world = props.tiny_world
end

function LevelSpawningSystem:onAdd(e)
  local level = e --[[@as Level]]
  local contents = level:get_contents()
  for _, entity in ipairs(contents) do
    entity.parent = level
    self.tiny_world:addEntity(entity)
  end
end

function LevelSpawningSystem:process(e, dt)
  if e.x <= LOWER_LEFT_BOUND then
    print('remove this level, danggit')
  end
end

return LevelSpawningSystem
