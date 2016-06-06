local config = require('lib.config').camera
local tiny   = require('lib.tiny')

local function Camera(world, timer, camera)
  local system  = tiny.processingSystem()
  system.filter = tiny.requireAll('camera')

  function system:process(e, dt)
    local pos, size, state = e.position, e.size, e.state
    local dx, dy = 0, 0

    local center = pos.x + size.w/2
    local dx = (center > config.x.min and center or config.x.min) - camera.x

    local h = config.window.h
    local ct, cb = camera.y - h/2, camera.y + h/2
    local bottom = pos.y + size.h
    bottom = bottom > config.y.max and config.y.max or bottom
    if bottom > cb or state:is('standing') then
      dy = bottom - cb
    elseif pos.y < ct then
      dy = pos.y - ct
    end

    camera:move(dx/2, dy/16)
  end

  return system
end

return Camera
