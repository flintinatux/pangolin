local tiny = require('vendor.tiny')

local graphics = love.graphics

local drawPoly = function(e)
  local height, pos, size, sprite = e.height, e.pos, e.size, e.sprite
  local r, g, b = sprite.r, sprite.g, sprite.b

  local vertices = {
    pos.x,          height.l,
    pos.x + size.w, height.r,
    pos.x + size.w, height.r + size.h,
    pos.x,          height.l + size.h
  }

  graphics.setColor(r, g, b, 70)
  graphics.polygon('fill', vertices)
  graphics.setColor(r, g, b)
  graphics.polygon('line', vertices)
end

local drawRect = function(e)
  local pos, size, sprite = e.pos, e.size, e.sprite
  local r, g, b = sprite.r, sprite.g, sprite.b

  graphics.setColor(r, g, b, 70)
  graphics.rectangle('fill', pos.x, pos.y, size.w, size.h)
  graphics.setColor(r, g, b)
  graphics.rectangle('line', pos.x, pos.y, size.w, size.h)
end

local function Sprite(res)
  local camera, world = res.camera, res.world
  local system  = tiny.system({ draw = true })

  function system:update()
    local l, t = camera:worldCoords(0, 0)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local entities, len = world.queryRect(l, t, w, h)

    if entities then
      table.sort(entities, function(a, b) return a.zIndex < b.zIndex end)
      for _, e in ipairs(entities) do
        local draw = e.height and drawPoly or drawRect
        draw(e)
      end
    end
  end

  return system
end

return Sprite
