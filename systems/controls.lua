local config = require('lib.config')
local tiny   = require('lib.tiny')

local jump, run = config.jump, config.run

local function Controls(world, timer)
  local system = tiny.processingSystem()

  system.filter = tiny.requireAll('controls')

  function system:process(e, dt)
    local c, j, m, s = e.controls, e.jump, e.motion, e.state

    if c.quit then love.event.push('quit') end

    local dir   = c.left and -1 or (c.right and 1 or 0)
    local vgoal = c.turbo and run.vmax or run.vmin
    m.ax = (dir * vgoal - m.vx) / run.dt

    if c.jump and s:jump() then
      if math.abs(m.vx) > run.vmin then
        m.vy = jump.vmin + (jump.vmax - jump.vmin) * (math.abs(m.vx) - run.vmin) / (run.vmax - run.vmin)
      else
        m.vy = jump.vmin
      end
    end
  end

  return system
end

return Controls
