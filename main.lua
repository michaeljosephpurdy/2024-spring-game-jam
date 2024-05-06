PubSub = require('plugins.pubsub')
tiny = require('plugins.tiny-ecs')
class = require('plugins.middleclass')
bump = require('plugins.bump')

Player = require('entities.player')
Level = require('entities.level')

GAME_WIDTH = 640
GAME_HEIGHT = 360
SIXTY_FPS = 60 / 1000

SYSTEMS_IN_ORDER = {
  require('systems.level-spawning-system'),
  require('systems.collision-registration-system'),
  require('systems.cooldown-system'),
  require('systems.player-input-system'),
  require('systems.collision-detection-system'),
  require('systems.camera-system'),
  require('systems.polygon-drawing-system'),
  require('systems.side-count-printing-system'),
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
  bump_world = bump.newWorld(64)
  tiny_world = tiny.world()
  --
  for _, system in ipairs(SYSTEMS_IN_ORDER) do
    if system.initialize then
      system:initialize({
        bump_world = bump_world,
        tiny_world = tiny_world,
      })
    end
    tiny_world:addSystem(system)
  end
  tiny_world:addEntity(Player:new())
  tiny_world:addEntity(Level:new())
  accumulator = 0
end

function love.update(dt)
  accumulator = accumulator + dt
  while accumulator >= SIXTY_FPS do
    tiny_world:update(SIXTY_FPS, UPDATE_SYSTEMS)
    accumulator = accumulator - SIXTY_FPS
  end
end

function love.draw()
  local dt = love.timer.getDelta()
  tiny_world:update(dt, DRAW_SYSTEMS)
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
