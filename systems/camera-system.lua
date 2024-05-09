local CameraSystem = tiny.processingSystem()
CameraSystem.filter = tiny.requireAll('camera_follow')
CameraSystem.is_draw_system = true

function CameraSystem:initialize(props)
  self.push = require('plugins.push')
  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  self.push:setupScreen(GAME_WIDTH, GAME_HEIGHT, windowWidth, windowHeight, {
    fullscreen = false,
    resizable = true,
  })
  self.push:resize(windowWidth, windowHeight)
  self.push:setBorderColor(PALETTE.LIGHTEST)
  PubSub.subscribe('love.resize', function(data)
    self.push:resize(data[1], data[2])
  end)
end

function CameraSystem:preWrap(dt)
  self.push:start()
end

function CameraSystem:postWrap(dt)
  self.push:finish()
end

function CameraSystem:process(e, dt)
  if e.x then
    love.graphics.translate(-e.x + GAME_WIDTH / 8, 0)
  end
end

return CameraSystem
