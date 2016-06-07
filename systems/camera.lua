local config = require('lib.config').camera
local tiny   = require('lib.tiny')

local function Camera(world, timer, camera)
  local system  = tiny.processingSystem()
  system.filter = tiny.requireAll('camera')

  function system:process(e, dt)
    local pos, size, state = e.position, e.size, e.state
    local dx, dy = 0, 0

    local dx = pos.x + size.w/2 - camera.x

    local h = config.window.h
    local ct, cb = camera.y - 2*h/3, camera.y + h/3
    local bottom = pos.y + size.h
    bottom = bottom > config.y.max and config.y.max or bottom
    if bottom > cb or state:is('standing') then
      dy = bottom - cb
    elseif pos.y < ct then
      dy = pos.y - ct
    end

    camera:move(32*dx*dt, 8*dy*dt)
  end

  return system
end

return Camera
