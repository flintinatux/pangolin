local config = require('lib.config')
local fun    = require('lib.fun')
local tiny   = require('lib.tiny')

local jump, run = config.jump, config.run

local function Controls(world, timer)
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('controls')

  local dispatch = {}

  function dispatch.jump(e, dt)
    local c, m, s = e.controls.states, e.motion, e.state
    if s:jump() then
      m.vy = c.turbo and math.abs(m.vx) > jump.threshold and jump.vmax or jump.vmin
    end
  end

  function dispatch.quit(e, dt)
    love.event.push('quit')
  end

  function system:process(e, dt)
    local c, m = e.controls.states, e.motion

    for _, action in ipairs(e.controls.actions) do dispatch[action](e, dt) end
    e.controls.actions = {}

    local dir   = c.left and -1 or (c.right and 1 or 0)
    local vgoal = c.turbo and run.vmax or run.vmin
    m.ax = (dir == 0 and 2 or 1) * (dir * vgoal - m.vx) / run.dt
  end

  return system
end

return Controls
