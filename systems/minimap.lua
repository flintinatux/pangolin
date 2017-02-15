local _      = require('vendor.moses')
local config = require('lib.config')
local tiny   = require('vendor.tiny')

local graphics = love.graphics
local tile = config.tile

local function Minimap(world, timer, camera)
  local system  = tiny.processingSystem({ hud = true })
  system.filter = tiny.requireAll('minimap', 'sprite')
  system.active = false

  local function onMinimap(draw)
    graphics.push()
    graphics.translate(graphics.getWidth()/2, 60)
    graphics.scale(1/tile.w, 1/tile.w)
    graphics.translate(-camera.x, 0)
    draw()
    graphics.pop()
  end

  local function posx(e) return e.position.x end
  local function posy(e) return e.position.y end

  function system:preProcess(dt)
    local entities = system.entities
    local xmin, ymin = _.min(entities, posx), _.min(entities, posy)
    local xmax, ymax = _.max(entities, posx), _.max(entities, posy)

    onMinimap(function()
      graphics.setColor(0, 0, 0, 150)
      graphics.rectangle('fill', xmin, ymin, xmax-xmin, ymax-ymin)
    end)
  end

  function system:process(e, dt)
    local p, s = e.position, e.size
    local r, g, b = e.sprite.r, e.sprite.g, e.sprite.b
    local em = e.player and 3 or 1

    onMinimap(function()
      graphics.setColor(r, g, b, 150)
      graphics.rectangle('fill', p.x, p.y-em*s.h, em*s.w, em*s.h)
    end)
  end

  return system
end

return Minimap
