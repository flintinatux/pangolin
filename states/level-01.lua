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
      fun.range( 0, 31):map(function(i) return Ground(i * w, 23 * h) end),
      fun.range(10, 21):map(function(i) return Ground(i * w, 19 * h) end),
      fun.range(13, 18):map(function(i) return Ground(i * w, 15 * h) end),
      {
        Ground(-w, 22 * h),
        Ground(32 * w, 22 * h),
        Player(384, 209)
      }
    )
  end

  return state
end

return Level01
