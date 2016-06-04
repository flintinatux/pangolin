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
      fun.range( 1, 30):map(function(i) return Ground( i * w, 23 * h) end),
      fun.range(10, 21):map(function(i) return Ground( i * w, 19 * h) end),
      fun.range(13, 18):map(function(i) return Ground( i * w, 15 * h) end),
      fun.range( 1,  4):map(function(i) return Ground( i * w, 11 * h) end),
      fun.range(27, 30):map(function(i) return Ground( i * w, 11 * h) end),
      fun.range(13, 18):map(function(i) return Ground( i * w,  7 * h) end),
      fun.range( 0, 23):map(function(i) return Ground(     0,  i * h) end),
      fun.range( 0, 23):map(function(i) return Ground(31 * w,  i * h) end),
      {
        Player(384, 209)
      }
    )
  end

  return state
end

return Level01
