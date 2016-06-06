local config = require('lib.config')
local tiny   = require('lib.tiny')

local cx, cy = love.graphics:getWidth()/2, love.graphics.getHeight()/2
local g = love.graphics
local h = config.camera.window.h

local debug = [[
  pos.x: ${x}
  pos.y: ${y}
  state: ${state}
]]

local function round(num, dec)
  dec = dec or 0
  return math.floor(num * 10^dec) / 10^dec
end

local function Debug()
  local system = tiny.processingSystem({ debug = true })
  system.filter = tiny.requireAll('player')

  function system:process(e, dt)
    local pos, state = e.position, e.state

    -- camera window
    g.setColor(255, 255, 255, 70)
    g.line(cx, cy - h/2, cx, cy + h/2)
    g.line(cx - 10, cy - h/2, cx + 10, cy - h/2)
    g.line(cx - 10, cy + h/2, cx + 10, cy + h/2)

    -- debug output
    local ctx = {
      x = round(pos.x, 2),
      y = round(pos.y, 2),
      state = state.current
    }
    g.print(debug % ctx, 50, 50)
  end

  return system
end

return Debug
