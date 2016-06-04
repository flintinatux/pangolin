local Base   = require('states.base')
local fun    = require('lib.fun')
local Ground = require('entities.ground')
local Player = require('entities.player')

local function Level01()
  local state = Base()

  function state:entities()
    return fun.chain(
      fun.range( 0, 24):map(function(i) return Ground(i * 32, 418) end),
      fun.range(10, 14):map(function(i) return Ground(i * 32, 290) end),
      {
        Ground(-32, 386),
        Ground(800, 386),
        Player(384, 209)
      }
    )
  end

  return state
end

return Level01
