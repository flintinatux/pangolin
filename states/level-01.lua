local Base   = require('states.base')
local config = require('lib.config')
local fun    = require('lib.fun')
local Ground = require('entities.ground')
local Player = require('entities.player')

local function Level01()
  local state = Base()
  local h, w = config.tile.h, config.tile.w

  function state:entities()
    return fun.chain(
      fun.range(0, 99):map(function(i) return Ground( i * w, 23 * h) end),
      {
        Player(0, 22 * h)
      }
    )
  end

  return state
end

return Level01
