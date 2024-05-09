local LevelSelectionTriggerEvent = class('LevelSelectionTriggerEvent')
LevelSelectionTriggerEvent.level_selection = true
LevelSelectionTriggerEvent.is_event = true
LevelSelectionTriggerEvent.time_to_live = 0

function LevelSelectionTriggerEvent:initialize() end

return LevelSelectionTriggerEvent
