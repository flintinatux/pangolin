-- local config = require('lib.config')
local tiny   = require('vendor.tiny')

-- local atan, cos, sin = math.atan, math.cos, math.sin

-- local angle = function(g)
--   return atan((g.height.r - g.height.l) / g.size.w)
-- end

local groundY = function(g, x)
  return g.height.l + (g.height.r - g.height.l) * (x - g.pos.x) / g.size.w
end

local function PlayerPhysics()
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('player')
  system.active = true

  function system:process(e)
    -- local controls = e.controls.states
    local motion, pad, pos, size, state = e.motion, e.pad, e.pos, e.size, e.state
    local fall = true

    for _, c in ipairs(e.collision) do
      local o = c.other

      if o.ground then
        local bottom = pos.y + size.h - pad.b
        local center = pos.x + size.w/2
        local left   = o.pos.x
        local right  = o.pos.x + o.size.w

        if inRange(left, right, center) then
          local y = groundY(o, center)

          if state:is('running') or motion.vy > 0 and bottom >= y then
            pos.y = y - size.h + pad.b
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
