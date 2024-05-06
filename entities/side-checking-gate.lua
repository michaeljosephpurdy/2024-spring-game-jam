---@class SideCheckingGate
local SideCheckingGate = class('SideCheckingGate')

function SideCheckingGate:initialize(x, y, sides)
  self.x, self.y = x, y
  self.sides = sides or 3
end

return SideCheckingGate
