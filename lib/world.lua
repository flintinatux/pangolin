local _       = require('lib.moses')
local Camera  = require('lib.camera')
local filter  = require('lib.filter')
local fun     = require('lib.fun')
local systems = require('systems.index')
local Timer   = require('lib.timer')

local function World()
  local bump   = require('lib.bump').newWorld()
  local camera = Camera.new(0, 0)
  local timer  = Timer.new()
  local tiny   = require('lib.tiny').world()
  local world  = {}

  function world.add(e)
    bump:add(e, e.position.x, e.position.y, e.size.w, e.size.h)
    tiny:add(e)
  end

  function world.addSystem(System)
    tiny:addSystem(System(world, timer, camera))
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
    timer:update(dt)
    tiny:update(dt, filter.by('update'))
  end

  return world
end

return World
