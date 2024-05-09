local MenuOption = class('MenuOption')

function MenuOption:initialize(x, y, message, on_click)
  self.clean_message = message
  self.x, self.y = x, y
  self.on_click = on_click
  self.message = self.clean_message
  self.is_active = false
end

function MenuOption:disable()
  self.message = self.clean_message
  self.is_active = false
end

function MenuOption:enable()
  self.message = '> ' .. self.clean_message
  self.is_active = true
end

return MenuOption
