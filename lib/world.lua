local _       = require('vendor.moses')
local Camera  = require('vendor.camera')
local filter  = require('lib.filter')
local fun     = require('vendor.fun')
local systems = require('systems.index')

local function World()
  local bump   = require('vendor.bump').newWorld()
  local camera = Camera.new(0, 0)
  local tiny   = require('vendor.tiny').world()
  local world  = {}

  local res = {
    camera = camera,
    world  = world
  }

  function world.add(e)
    bump:add(e, e.position.x, e.position.y, e.size.w, e.size.h)
    tiny:add(e)
  end

  function world.addSystem(System)
    tiny:addSystem(System(res))
  end

  function world:draw()
    camera:attach()
    tiny:update(love.timer.getDelta(), filter.by('draw'))
    camera:detach()
    tiny:update(love.timer.getDelta(), filter.by('hud'))
  end

  function world:init()
    fun.each(world.addSystem, systems)
    fun.each(world.add, world.entities())
  end

  function world.move(e, x, y, warp)
    if warp then
      e.position.x = x
      e.position.y = y
      bump:update(e, x, y)
    else
      e.position.x, e.position.y, e.collision = bump:move(e, x, y, filter.bump)
    end
  end

  world.queryPoint   = _.bind(bump.queryPoint,   bump)
  world.queryRect    = _.bind(bump.queryRect,    bump)
  world.querySegment = _.bind(bump.querySegment, bump)

  function world.remove(e)
    bump:remove(e)
    tiny:remove(e)
  end

  function world:update(dt)
    tiny:update(dt, filter.by('update'))
  end

  return world
end

return World
