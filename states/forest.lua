local _      = require('lib.moses')
local World  = require('lib.world')
local config = require('lib.config')
local fun    = require('lib.fun')
local Ground = require('entities.ground')
local Player = require('entities.player')

local map, tile = config.map, config.tile

local function Forest()
  local world = World()
  local h, w = tile.h, tile.w

  function world.entities()
    math.randomseed(os.time())
    local tiles = fun.range(0, map.w-1)
    local x = tiles:zip(fun.duplicate(w)):map(fun.operator.mul)

    local delta = {0,0,0,0,0,0,0,0,0,0,0,0,1,-1}
    local y = {0}
    tiles:take(map.w/2):each(function()
      table.insert(y, y[#y] + delta[math.random(1,#delta)] * h)
    end)
    y = fun.chain(y, _.reverse(y))

    return fun.chain(
      fun.zip(x, y):map(Ground),
      {
        Player(0, y:head() - h)
      }
    )
  end

  return world
end

return Forest
