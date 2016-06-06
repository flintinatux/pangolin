local config = require('lib.config')
local tiny   = require('lib.tiny')

local function PlayerPhysics(world, timer, camera)
  local system  = tiny.processingSystem()
  system.filter = tiny.requireAll('player')

  function system:process(e, dt)
    local m, p, s = e.motion, e.position, e.state

    m.ay = config.physics.g

    for _, c in ipairs(e.collision) do
      if c.other.ground then
        if c.normal.x ~= 0 then
          m.vx = 0
        end

        if c.normal.y == 1 then
          m.vy = 0
        elseif c.normal.y == -1 then
          s:land()
          m.vy = 0
          m.ay = 0
        end
      end
    end
  end

  return system
end

return PlayerPhysics
