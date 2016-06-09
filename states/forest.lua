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

    -- Terrain
    local delta = {0,0,0,0,0,0,0,0,0,1}
    local x = tiles:zip(fun.duplicate(w)):map(fun.operator.mul)
    local y, dy = {0}, {}
    fun.range(map.w/2):each(function()
      local choice = delta[math.random(1,#delta)]
      table.insert(dy,  choice)
      table.insert(dy, -choice)
    end)
    for i, dy in ipairs(_.shuffle(dy)) do
      table.insert(y, y[#y] + dy * h)
    end
    local grounds = fun.zip(x, y):map(Ground)

    -- Branches
    local branches = {}
    fun.range(map.branches):each(function()
      -- TODO: build branches
    end)

    return fun.chain(
      grounds,
      {
        Player(-w/2, y[1] - h)
      }
    )
  end

  return world
end

return Forest
