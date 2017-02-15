local fun  = require('vendor.fun')
local tiny = require('vendor.tiny')

local graphics = love.graphics

local function Sprite(res)
  local camera, world = res.camera, res.world
  local system  = tiny.system({ draw = true })

  local function drawSprite(e)
    local pos, size, sprite = e.position, e.size, e.sprite
    local r, g, b = sprite.r, sprite.g, sprite.b

    graphics.setColor(r, g, b, 70)
    graphics.rectangle('fill', pos.x, pos.y, size.w, size.h)
    graphics.setColor(r, g, b)
    graphics.rectangle('line', pos.x, pos.y, size.w, size.h)
  end

  function system:update(dt)
    local l, t = camera:worldCoords(0, 0)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local entities, len = world.queryRect(l, t, w, h)

    if (entities) then
      table.sort(entities, function(a, b) return a.zIndex < b.zIndex end)
      for i, e in ipairs(entities) do drawSprite(e) end
    end
  end

  return system
end

return Sprite
