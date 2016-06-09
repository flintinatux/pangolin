local config = require('lib.config')
local filter = require('lib.filter')
local tiny   = require('lib.tiny')

local tile, window = config.tile, config.camera.window

local function Camera(world, timer, camera)
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('camera')

  function system:process(e, dt)
    local pos, size, state = e.position, e.size, e.state
    local dx, dy = 0, 0

    local dx = pos.x + size.w/2 - camera.x

    local ct, cb = camera.y - 2*window.h/3, camera.y + window.h/3
    local bottom = pos.y + size.h

    local height = love.graphics.getHeight()
    local ground = world.queryRect(pos.x, pos.y + size.h, size.w, height/2, filter.by('ground'))[1]

    if (ground) then
      local limit = ground.position.y - height/3 + tile.h
      bottom = bottom > limit and limit or bottom
    end

    if bottom > cb or state:is('standing') then
      dy = bottom - cb
    elseif pos.y < ct then
      dy = pos.y - ct
    end

    camera:move(32*dx*dt, 4*dy*dt)
  end

  return system
end

return Camera
