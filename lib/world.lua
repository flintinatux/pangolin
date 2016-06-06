local Camera = require('lib.camera')
local Timer  = require('lib.timer')

local function bumpFilter(e, other) return other.bump  end
local function debugFilter  (_, s)  return     s.debug end
local function drawFilter   (_, s)  return     s.draw  end
local function updateFilter (_, s)  return not s.draw  end

local function World()
  local bump   = require('lib.bump').newWorld()
  local camera = Camera.new()
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
    tiny:update(love.timer.getDelta(), drawFilter)
    camera:detach()
    tiny:update(love.timer.getDelta(), debugFilter)
  end

  function world.move(e, x, y)
    e.position.x, e.position.y, e.collision = bump:move(e, x, y, bumpFilter)
  end

  function world.remove(e)
    bump:remove(e)
    tiny:remove(e)
  end

  function world.update(dt)
    timer:update(dt)
    tiny:update(dt, updateFilter)
  end

  return world
end

return World
