local config = require('lib.config')
local fun    = require('lib.fun')
local tiny   = require('lib.tiny')

local function Controls(world, timer)
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('controls')

  local actions = {}

  function actions.jump(e, dt)
    local c, m, s = e.controls.states, e.motion, e.state
    if s:jump() then
      m.vy = c.turbo and math.abs(m.vx) > config.jump.threshold
        and config.jump.vmax
        or  config.jump.vmin
    end
  end

  function actions.quit(e, dt)
    love.event.push('quit')
  end

  local function climb(e, dt)
    local c, m = e.controls.states, e.motion
    local horz = c.right and 1 or (c.left and -1 or 0)
    local vert = c.up and -1 or (c.down and 1 or 0)
    m.vx = horz * config.climb.v
    m.vy = vert * config.climb.v
    m.ax = 0
  end

  local function run(e, dt)
    local c, m  = e.controls.states, e.motion
    local dir   = c.left and -1 or (c.right and 1 or 0)
    local vgoal = c.turbo and config.run.vmax or config.run.vmin
    m.ax = (dir == 0 and 2 or 1) * (dir * vgoal - m.vx) / config.run.dt
  end

  function system:process(e, dt)
    local s = e.state
    for _, action in ipairs(e.controls.actions) do actions[action](e, dt) end
    e.controls.actions = {}

    if (s:is('climbing')) then
      climb(e, dt)
    else
      run(e, dt)
    end
  end

  return system
end

return Controls
