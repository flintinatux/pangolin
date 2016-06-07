local config = require('lib.config')
local tiny   = require('lib.tiny')

local cx, cy = love.graphics:getWidth()/2, love.graphics.getHeight()/2
local graphics = love.graphics
local h = config.camera.window.h

local debug = [[
  fps: ${fps}
  pos.x: ${x}
  pos.y: ${y}
  state: ${state}
]]

local function round(num, dec)
  dec = dec or 0
  return math.floor(num * 10^dec) / 10^dec
end

local function Debug(world, timer, camera)
  local system  = tiny.processingSystem({ debug = true })
  system.filter = tiny.requireAll('player')

  function system:process(e, dt)
    local pos, state = e.position, e.state

    -- camera window
    local t, b = cy - 2*h/3, cy + h/3
    graphics.setColor(255, 255, 255, 70)
    graphics.line(cx, t, cx, b)
    graphics.line(cx - 10, t, cx + 10, t)
    graphics.line(cx - 10, b, cx + 10, b)

    -- debug output
    local ctx = {
      fps = love.timer.getFPS(),
      x = round(pos.x, 2),
      y = round(pos.y, 2),
      state = state.current
    }
    graphics.print(debug % ctx, 50, 50)
  end

  return system
end

return Debug
