local config = require('lib.config').camera
local tiny   = require('lib.tiny')

local function Camera(world, timer, camera)
  local system  = tiny.processingSystem()
  system.filter = tiny.requireAll('camera')

  function system:process(e, dt)
    local p = e.position
    local dx = (p.x > config.xmin and p.x or config.xmin) - camera.x
    local dy = (p.y < config.ymax and p.y or config.ymax) - camera.y
    camera:move(dx/2, dy/2)
  end

  return system
end

return Camera
