local tiny = require('vendor.tiny')

local graphics = love.graphics

local drawGround = function(e)
  local height, pos, size, sprite = e.height, e.pos, e.size, e.sprite
  local r, g, b = sprite.r, sprite.g, sprite.b

  local fill = {
    pos.x,          height.l,
    pos.x + size.w, height.r,
    pos.x + size.w, height.r + size.h,
    pos.x,          height.l + size.h
  }

  local top = {
    pos.x,          height.l,
    pos.x + size.w, height.r
  }

  graphics.setColor(r, g, b, 70)
  graphics.polygon('fill', fill)
  graphics.setColor(r, g, b)
  graphics.setLineWidth(2)
  graphics.line(top)
  graphics.setLineWidth(1)
end

local drawRect = function(e)
  local pos, size, sprite = e.pos, e.size, e.sprite
  local r, g, b = sprite.r, sprite.g, sprite.b

  graphics.setColor(r, g, b, 70)
  graphics.rectangle('fill', pos.x, pos.y, size.w, size.h)
  graphics.setColor(r, g, b)
  graphics.rectangle('line', pos.x, pos.y, size.w, size.h)
end

local drawPlayer = function(e)
  local pad, pos, size, sprite = e.pad, e.pos, e.size, e.sprite
  local r, g, b = sprite.r, sprite.g, sprite.b

  graphics.setColor(r, g, b, 70)
  graphics.rectangle('fill', pos.x, pos.y, size.w, size.h - pad.b)
  graphics.setColor(r, g, b)
  graphics.rectangle('line', pos.x, pos.y, size.w, size.h - pad.b)
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
        (
          e.ground and drawGround or
          e.player and drawPlayer or
                       drawRect
        )(e)
      end
    end
  end

  return system
end

return Sprite
