local tiny   = require('lib.tiny')

local function Sprite()
  local system = tiny.processingSystem({ draw = true })

  system.filter = tiny.requireAll('position', 'sprite')

  function system:process(e, dt)
    local p, s = e.position, e.size
    local r, g, b = e.sprite.r, e.sprite.g, e.sprite.b

    love.graphics.setColor(r, g, b, 70)
    love.graphics.rectangle('fill', p.x, p.y, s.w, s.h)
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle('line', p.x, p.y, s.w, s.h)
  end

  return system
end

return Sprite
