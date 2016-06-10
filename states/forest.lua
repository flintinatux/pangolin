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
  local deltas = {0,0,0,0,0,0,0,0,0,0,1,-1}

  local function sample(array)
    return array[math.random(1,#array)]
  end

  function world.entities()
    math.randomseed(os.time())

    -- Terrain
    local tiles = fun.range(0, map.w-1)
    local gx = tiles:zip(fun.duplicate(w)):map(fun.operator.mul)
    local gy, dy = {0}, {}
    fun.range(map.w/2):each(function()
      local choice = sample(deltas)
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
      local by = gy[bx+1] - math.random(3,50)*tile.h
      local len = math.random(4, 16)
      table.insert(branches, Branch(bx*tile.w, by))
      for m, n in fun.range(len) do
        by = by + sample(deltas)*tile.h
        table.insert(branches, Branch((bx+n)*tile.w, by))
      end
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
