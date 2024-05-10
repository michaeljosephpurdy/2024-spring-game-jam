PubSub = require('plugins.pubsub')
tiny = require('plugins.tiny-ecs')
class = require('plugins.middleclass')
bump = require('plugins.bump')

GAME_WIDTH = 640
GAME_HEIGHT = 360
SIXTY_TWO_FPS = 1 / 62
SIXTY_FPS = 1 / 60
GRAVITY = 25
MAX_GRAVITY = 800
JUMP_HEIGHT = 400

SYSTEMS_IN_ORDER = {
  require('systems.game-over-system'),
  require('systems.score-keeping-system'),
  require('systems.level-selection-system'),
  require('systems.endless-level-spawning-system'),
  require('systems.collision-registration-system'),
  require('systems.cooldown-system'),
  require('systems.left-movement-system'),
  require('systems.right-movement-system'),
  require('systems.speedup-system'),
  require('systems.player-input-system'),
  require('systems.entity-movement-system'),
  require('systems.gravity-system'),
  require('systems.vertical-position-checking-system'),
  require('systems.collision-detection-system'),
  require('systems.player-death-system'),
  require('systems.camera-system'),
  require('systems.background-sprite-drawing-system'),
  require('systems.sprite-drawing-system'),
  require('systems.foreground-sprite-drawing-system'),
  require('systems.message-overlay-system'),
  --require('systems.debug-overlay-system'),
  require('systems.entity-cleanup-system'),
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
  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.graphics.setBackgroundColor(PALETTE.LIGHTEST)

  -- Import all entities
  -- this is happening in love.load because this is after default filter is set
  Player = require('entities.player')
  Particle = require('entities.particle')
  SolidPlatform = require('entities.solid-platform')
  SideCheckingGate = require('entities.side-checking-gate')
  SpeedUpGate = require('entities.speedup-gate')
  Level = require('entities.level')
  EntityKiller = require('entities.entity-killer')

  MenuOption = require('entities.menu-option')

  FlipGravityEvent = require('entities.flip-gravity-event')
  SpeedupEvent = require('entities.speedup-event')
  MessageEvent = require('entities.message-event')
  GameOverEvent = require('entities.game-over-event')
  LevelSelectionTriggerEvent = require('entities.level-selection-trigger-event')
  KeyReleaseEvent = require('entities.keyrelease-event')
  ScreenShakeEvent = require('entities.screen-shake-event')

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
      })
    end
    tiny_world:addSystem(system)
  end
  --tiny_world:addEntity(LevelSelectionTriggerEvent())
  tiny_world:addEntity(Player(true))
  accumulator = 0
end

function love.update(dt)
  accumulator = accumulator + dt
  while accumulator >= SIXTY_TWO_FPS do
    tiny_world:update(SIXTY_FPS, UPDATE_SYSTEMS)
    accumulator = accumulator - SIXTY_FPS
    if accumulator < 0 then
      accumulator = 0
    end
  end
end

function love.draw()
  love.graphics.print(tostring(love.timer.getFPS(), 0, 0))
  local dt = love.timer.getDelta()
  tiny_world:update(dt, DRAW_SYSTEMS)
end

function love.keypressed(k)
  PubSub.publish('keypress', k)
end

function love.keyreleased(k)
  tiny_world:addEntity(KeyReleaseEvent(k))
end

function love.resize(w, h)
  PubSub.publish('love.resize', { w, h })
end
