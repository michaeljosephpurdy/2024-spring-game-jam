---@class Audio
---@field audio boolean
---@field is_one_shot boolean
local Audio = class('audio')
Audio.audio = true

function Audio:initialize(sound)
  self.one_shot = true
  local volume = 0.25

  if sound == 'jump' then
    self.source = love.audio.newSource('assets/jump.wav', 'static')
  elseif sound == 'death' then
    self.source = love.audio.newSource('assets/death.wav', 'static')
  elseif sound == 'speed' then
    self.source = love.audio.newSource('assets/speed.wav', 'static')
  elseif sound == 'landing' then
    self.source = love.audio.newSource('assets/landing.wav', 'static')
  elseif sound == 'flip' then
    self.source = love.audio.newSource('assets/flip.wav', 'static')
  elseif sound == 'music' then
    self.one_shot = false
    self.source = love.audio.newSource('assets/background-music.wav', 'stream')
    self.source:setLooping(true)
    volume = 0.125
  end
  self.source:setVolume(volume)
end

function Audio:play()
  self.source:play()
end

return Audio
