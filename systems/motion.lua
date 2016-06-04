local tiny = require('lib.tiny')

local function Motion(world)
  local system = tiny.processingSystem()

  system.filter = tiny.requireAll('motion', 'position')

  function system:process(e, dt)
    local m, p = e.motion, e.position
    local friction = 0

    if m.axmax and m.vxmax then
      friction = -(m.axmax / m.vxmax)
    end

    m.vx = m.vx * (1 + friction * dt) + m.ax * dt
    m.vy = m.vy + m.ay * dt

    local x = p.x + m.vx * dt
    local y = p.y + m.vy * dt

    world.move(e, x, y)
  end

  return system
end

return Motion
