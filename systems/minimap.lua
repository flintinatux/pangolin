local config = require('lib.config')
local tiny   = require('lib.tiny')

local graphics = love.graphics
local tile = config.tile

local function Minimap(world, timer, camera)
  local system  = tiny.processingSystem({ hud = true })
  system.filter = tiny.requireAll('minimap', 'sprite')

  function system:process(e, dt)
    local p, s = e.position, e.size
    local r, g, b = e.sprite.r, e.sprite.g, e.sprite.b
    local alpha = e.player and 150 or 70
    local em = e.player and 3 or 1

    graphics.push()
    graphics.translate(graphics.getWidth()/2, 100)
    graphics.scale(1/tile.w, 1/tile.w)
    graphics.translate(-camera.x, 0)
    graphics.setColor(r, g, b, alpha)
    graphics.rectangle('fill', p.x, p.y-em*s.h, em*s.w, em*s.h)
    graphics.pop()
  end

  return system
end

return Minimap
