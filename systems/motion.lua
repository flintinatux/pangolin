local tiny = require('lib.tiny')

local function Motion(world)
  local system = tiny.processingSystem()

  system.filter = tiny.requireAll('motion', 'position')

  function system:process(e, dt)
    local m, p = e.motion, e.position

    m.vx = m.vx + (m.ax or 0) * dt
    m.vy = m.vy + (m.ay or 0) * dt

    local x = p.x + m.vx * dt
    local y = p.y + m.vy * dt

    world.move(e, x, y)
  end

  return system
end

return Motion
