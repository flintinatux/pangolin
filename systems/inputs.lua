local tiny = require('lib.tiny')

local function Inputs()
  local system = tiny.processingSystem()

  system.filter = tiny.requireAll('inputs', 'controls')

  function system:process(e, dt)
    for ctrl, key in pairs(e.inputs) do
      e.controls[ctrl] = love.keyboard.isDown(key)
    end
  end

  return system
end

return Inputs
