local LevelSelectionSystem = tiny.processingSystem()
LevelSelectionSystem.filter = tiny.requireAny('level_selection', 'key_release')

function LevelSelectionSystem:onAdd(e)
  if not e.is_event then
    return
  end

  -- if it's a key release event, we need to find
  if e.class == KeyReleaseEvent then
    local previous = e.keycode == 'up'
    local next = e.keycode == 'down'
    local ok = e.keycode == 'space'
    if not previous and not next and not ok then
      return
    end
    for _, menu_option in pairs(self.entities) do
      if menu_option.class == MenuOption and menu_option.is_active then
        menu_option:disable()
        if previous then
          menu_option.previous:enable()
        elseif next then
          menu_option.next:enable()
        elseif ok then
          menu_option:on_click()
        end
        return
      end
    end
    return
  end

  self.world:addEntity(MessageEvent(' Lots of Sides\n\nby Mike Purdy', 999999, GAME_WIDTH / 2, GAME_HEIGHT / 4))
  local options = {
    MenuOption(0, 0, 'Level 1', function() end),
    MenuOption(0, 0, 'Level 2', function() end),
    MenuOption(0, 0, 'Level 3', function() end),
    MenuOption(0, 0, 'Level 4', function() end),
    MenuOption(0, 0, 'Endless', function()
      self.world:clearEntities()
      self.world:addEntity(Player(true))
    end),
  }
  -- we'll take a second to link all of these menu options
  -- into a linked list, to easily navigate through the menu
  for i, option in ipairs(options) do
    option.level_selection = true
    option.x = option.x + GAME_WIDTH / 2
    option.y = option.y + GAME_HEIGHT / 2 + (i * 20)
    option.previous = options[i - 1]
    option.next = options[i + 1]
    if i == 1 then
      option.previous = options[#options]
    end
    if i == #options then
      option.next = options[1]
    end
  end
  options[1]:enable()
  for _, option in pairs(options) do
    self.world:addEntity(option)
  end
end

function LevelSelectionSystem:update(dt)
  if #self.entities > 3 then
    self.world:addEntity(Particle(love.math.random(0, GAME_WIDTH), 0, 1, 'Decoration'))
  end
end

return LevelSelectionSystem
