local fun  = require('lib.fun')
local tiny = require('lib.tiny')

local graphics = love.graphics

local function Sprite(world, timer, camera)
  local system  = tiny.system({ draw = true })

  local function drawSprite(e)
    local p, s = e.position, e.size
    local r, g, b = e.sprite.r, e.sprite.g, e.sprite.b

    graphics.setColor(r, g, b, 70)
    graphics.rectangle('fill', p.x, p.y, s.w, s.h)
    graphics.setColor(r, g, b)
    graphics.rectangle('line', p.x, p.y, s.w, s.h)
  end

  function system:update(dt)
    local l, t = camera:worldCoords(0, 0)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local entities, len = world.queryRect(l, t, w, h)
    if (entities) then
      for i, e in ipairs(entities) do drawSprite(e) end
    end
  end

  return system
end

return Sprite
