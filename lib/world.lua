local _       = require('lib.moses')
local Camera  = require('lib.camera')
local filters = require('lib.filters')
local Timer   = require('lib.timer')

local function World()
  local bump   = require('lib.bump').newWorld()
  local camera = Camera.new(0)
  local timer  = Timer.new()
  local tiny   = require('lib.tiny').world()
  local world  = {}

  camera.smoother = Camera.smooth.damped(2)

  function world.add(e)
    bump:add(e, e.position.x, e.position.y, e.size.w, e.size.h)
    tiny:add(e)
  end

  function world.addSystem(System)
    tiny:addSystem(System(world, timer, camera))
  end

  function world.draw()
    camera:attach()
    tiny:update(love.timer.getDelta(), filters.draw)
    camera:detach()
    tiny:update(love.timer.getDelta(), filters.debug)
  end

  function world.move(e, x, y, warp)
    if warp then
      e.position.x = x
      e.position.y = y
      bump:update(e, x, y)
    else
      e.position.x, e.position.y, e.collision = bump:move(e, x, y, filters.bump)
    end
  end

  world.queryRect = _.bind(bump.queryRect, bump)

  function world.remove(e)
    bump:remove(e)
    tiny:remove(e)
  end

  function world.update(dt)
    timer:update(dt)
    tiny:update(dt, filters.update)
  end

  return world
end

return World
