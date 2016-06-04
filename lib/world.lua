local function World()
  local bump  = require('lib.bump').newWorld()
  local tiny  = require('lib.tiny').world()
  local world = {}

  function world.add(e)
    bump:add(e, e.position.x, e.position.y, e.size.w, e.size.h)
    tiny:add(e)
  end

  function world.addSystem(System)
    tiny:addSystem(System(world))
  end

  function world.move(e, x, y)
    e.position.x, e.position.y, e.collision = bump:move(e, x, y, bumpFilter)
  end

  function world.remove(e)
    bump:remove(e)
    tiny:remove(e)
  end

  function world.update(dt, filter)
    tiny:update(dt, filter)
  end

  function bumpFilter(e, other)
    return other.bump
  end

  return world
end

return World
