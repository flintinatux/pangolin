local _      = require('lib.moses')
local Base   = require('states.base')
local config = require('lib.config')
local fun    = require('lib.fun')
local Ground = require('entities.ground')
local Player = require('entities.player')

local map, tile = config.map, config.tile

local function Level01()
  local state = Base()
  local h, w = tile.h, tile.w

  local function shift(y) return (y + 23) * h end

  function state:entities()
    local tiles = fun.range(0, map.w-1)
    local x = tiles:zip(fun.duplicate(w)):map(fun.operator.mul)

    local delta = {0,0,0,0,0,0,0,0,0,0,0,0,1,-1}
    local y = {0}
    tiles:take(map.w/2):each(function()
      table.insert(y, y[#y] + delta[math.random(1,#delta)])
    end)
    y = fun.chain(y, _.reverse(y)):map(shift)

    return fun.chain(
      fun.zip(x, y):map(Ground),
      {
        Player(0, y:head() - h)
      }
    )
  end

  return state
end

return Level01
