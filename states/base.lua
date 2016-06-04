local fun     = require('lib.fun')
local systems = require('systems.index')
local World   = require('lib.world')

local function drawFilter   (_, s) return     s.draw end
local function updateFilter (_, s) return not s.draw end

local function Base()
  local state = {}
  local world = World()

  fun.each(world.addSystem, systems)

  function state:draw()
    world.update(love.timer.getDelta(), drawFilter)
  end

  function state:entities()
    -- override and return an array of entities
    return {}
  end

  function state:init()
    fun.each(world.add, state:entities())
  end

  function state:update(dt)
    world.update(dt, updateFilter)
  end

  return state
end

return Base
