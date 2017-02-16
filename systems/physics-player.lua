-- local config = require('lib.config')
local tiny   = require('vendor.tiny')

local groundY = function(g, x)
  return g.height.l + (g.height.r - g.height.l) * (x - g.position.x) / g.size.w
end

local function PlayerPhysics()
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('player')
  system.active = true

  function system:process(e)
    -- local controls = e.controls.states
    local motion, pos, size, state = e.motion, e.position, e.size, e.state
    local fall = true

    for _, c in ipairs(e.collision) do
      local o = c.other

      if o.ground then
        local bottom = pos.y + size.h
        local center = pos.x + size.w/2
        local left   = o.position.x
        local right  = o.position.x + o.size.w

        if inRange(left, right, center) then
          local y = groundY(o, center)

          if motion.vy > 0 and bottom >= y then
            pos.y = y - size.h
            motion.vy = 0
            state:land()
            fall = false
          end
        end
      end
    end

    if fall then state:fall() end
  end

  return system
end

return PlayerPhysics

-- if c.other.trunk and c.overlaps then
--   if controls.up then s:climb() end
--   if s:is('climbing') then
--     fall = false
--     m.ay = 0
--   end
-- end
