PubSub = require('plugins.pubsub')
tiny = require('plugins.tiny-ecs')
class = require('plugins.middleclass')
bump = require('plugins.bump')

GAME_WIDTH = 640
GAME_HEIGHT = 360
SIXTY_FPS = 60 / 1000

SYSTEMS_IN_ORDER = {
  require('systems.level-spawning-system'),
  require('systems.collision-registration-system'),
  require('systems.cooldown-system'),
  require('systems.left-movement-system'),
  require('systems.right-movement-system'),
  require('systems.player-input-system'),
  require('systems.gravity-system'),
  require('systems.collision-detection-system'),
  require('systems.player-death-system'),
  require('systems.camera-system'),
  require('systems.sprite-drawing-system'),
  require('systems.entity-cleanup-system'),
  require('systems.debug-overlay-system'),
}

PALETTE = {
  DARKEST = { love.math.colorFromBytes(27, 13, 53) },
  DARK = { love.math.colorFromBytes(47, 28, 98) },
  LIGHT = { love.math.colorFromBytes(86, 52, 130) },
  LIGHTEST = { love.math.colorFromBytes(111, 93, 157) },
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
  love.graphics.setBackgroundColor(PALETTE.LIGHTEST)

  -- Import all entities
  -- this is happening in love.load because this is after default filter is set
  Player = require('entities.player')
  Particle = require('entities.particle')
  SolidPlatform = require('entities.solid-platform')
  SideCheckingGate = require('entities.side-checking-gate')
  Level = require('entities.level')
  EntityKiller = require('entities.entity-killer')

  --
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
  tiny_world:addEntity(Player())
  tiny_world:addEntity(EntityKiller())
  local level = Level()
  tiny_world:addEntity(level)
  tiny_world:addEntity(Level(level.x + level.width))
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
