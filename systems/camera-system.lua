local CameraSystem = tiny.processingSystem()
CameraSystem.filter = tiny.requireAll('camera_follow')
CameraSystem.is_draw_system = true

local function lerp(a, b, t)
  return a + (b - a) * t
end

function CameraSystem:initialize(props)
  self.push = require('plugins.push')
  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  self.push:setupScreen(GAME_WIDTH, GAME_HEIGHT, windowWidth, windowHeight, {
    fullscreen = false,
    resizable = true,
  })
  self.push:resize(windowWidth, windowHeight)
  self.push:setBorderColor(love.math.colorFromBytes(115, 239, 247))
  self.push:setBorderColor(love.math.colorFromBytes(26, 28, 44))
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
  love.graphics.translate(0, 0)
  love.graphics.print('2024 spring game jam', 20, 20)
end

return CameraSystem
