local LevelSpawningSystem = tiny.processingSystem()
LevelSpawningSystem.filter = tiny.requireAll('is_level')

function LevelSpawningSystem:process(e, dt)
  if e.x <= LOWER_LEFT_BOUND then
    print('remove this level, danggit')
  end
end

return LevelSpawningSystem
