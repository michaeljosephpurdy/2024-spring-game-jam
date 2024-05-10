---@class Audio
---@field audio boolean
---@field is_one_shot boolean
local Audio = class('audio')
Audio.audio = true

function Audio:initialize(sound)
  self.one_shot = true

  if sound == 'music' then
    self.one_shot = false
    self.source = love.audio.newSource('assets/background-music.wav', 'static')
    self.source:setLooping(true)
    self.source:setVolume(0.5)
  end
end

function Audio:play()
  self.source:play()
end

return Audio
