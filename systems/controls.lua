local tiny = require('lib.tiny')

local config = require('lib.config')

local jump, run = config.jump, config.run

local function Controls()
  local system = tiny.processingSystem()

  system.filter = tiny.requireAll('controls')

  function system:process(e, dt)
    local c, j, m, s = e.controls, e.jump, e.motion, e.state

    if c.quit then love.event.push('quit') end

    if c.turbo then
      m.vxmax = run.vmax
    else
      m.vxmax = run.vmin
    end

    if c.left then
      m.ax = -run.a
    elseif c.right then
      m.ax = run.a
    else
      m.ax = 0
    end

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
