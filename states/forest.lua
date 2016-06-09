local _      = require('lib.moses')
local World  = require('lib.world')
local config = require('lib.config')
local fun    = require('lib.fun')
local Branch = require('entities.branch')
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
    local gx = tiles:zip(fun.duplicate(w)):map(fun.operator.mul)
    local gy, dy = {0}, {}
    fun.range(map.w/2):each(function()
      local choice = delta[math.random(1,#delta)]
      table.insert(dy,  choice)
      table.insert(dy, -choice)
    end)
    for i, dy in ipairs(_.shuffle(dy)) do
      table.insert(gy, gy[#gy] + dy * h)
    end
    local grounds = fun.zip(gx, gy):map(Ground)

    -- Branches
    local branches = {}
    fun.range(map.branches):each(function()
      local bx = math.random(0, map.w-1)
      local by = gy[bx+1] - math.random(3,25)*tile.h
      table.insert(branches, Branch(bx*tile.w, by))
    end)

    return fun.chain(
      grounds,
      branches,
      {
        Player(-w/2, gy[1] - h)
      }
    )
  end

  return world
end

return Forest
