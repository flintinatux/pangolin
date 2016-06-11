local config = require('lib.config')
local tiny   = require('lib.tiny')

local function PlayerPhysics(world, timer, camera)
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('player')

  function system:process(e, dt)
    local controls = e.controls.states
    local m, p, s = e.motion, e.position, e.state
    local fall = true

    m.ay = config.physics.g

    for _, c in ipairs(e.collision) do
      if c.type == 'slide' then
        if c.normal.x ~= 0 then
          m.vx = 0
        end

        if c.normal.y == 1 then
          m.vy = 0
        elseif c.normal.y == -1 then
          fall = not s:land()
          m.vy = 0
          m.ay = 0
        end
      end

      if c.other.trunk and c.overlaps then
        if controls.up then s:climb() end
        if s:is('climbing') then
          fall = false
          m.ay = 0
        end
      end
    end

    if (fall) then s:fall() end
  end

  return system
end

return PlayerPhysics
