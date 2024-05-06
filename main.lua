PubSub = require('plugins.pubsub')
tiny = require('plugins.tiny-ecs')
class = require('plugins.middleclass')

Player = require('entities.player')

GAME_WIDTH = 640
GAME_HEIGHT = 360
SIXTY_FPS = 60 / 1000

SYSTEMS_IN_ORDER = {
  require('systems.cooldown-system'),
  require('systems.player-input-system'),
  require('systems.level-spawning-system'),
  require('systems.camera-system'),
  require('systems.polygon-drawing-system'),
}

UPDATE_SYSTEMS = function(_, s)
  return not s.is_draw_system
end
DRAW_SYSTEMS = function(_, s)
  return s.is_draw_system
end

function love.load()
  PubSub.subscribe('keypress', function(k)
    if k ~= 'escape' then
      return
    end
    love.event.quit()
  end)
  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.graphics.setLineStyle('rough')
  love.window.setMode(640, 360)
  world = tiny.world()
  for _, system in ipairs(SYSTEMS_IN_ORDER) do
    if system.init then
      system:init({})
    end
    world:addSystem(system)
  end
  world:addEntity(Player:new())
  accumulator = 0
end

function love.update(dt)
  accumulator = accumulator + dt
  while accumulator >= SIXTY_FPS do
    world:update(SIXTY_FPS, UPDATE_SYSTEMS)
    accumulator = accumulator - SIXTY_FPS
  end
end

function love.draw()
  local dt = love.timer.getDelta()
  world:update(dt, DRAW_SYSTEMS)
end

function love.keypressed(k)
  PubSub.publish('keypress', k)
end

function love.keyreleased(k)
  PubSub.publish('keyrelease', k)
end

function love.resize(w, h)
  PubSub.publish('love.resize', { w, h })
end
