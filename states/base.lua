local fun     = require('lib.fun')
local systems = require('systems.index')
local World   = require('lib.world')

local function Base()
  local state = {}
  local world = World()

  fun.each(world.addSystem, systems)

  function state:draw()
    world.draw()
  end

  function state:entities()
    -- override and return an array of entities
    return {}
  end

  function state:init()
    fun.each(world.add, state:entities())
  end

  function state:update(dt)
    world.update(dt)
  end

  return state
end

return Base
