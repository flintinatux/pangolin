local _      = require('vendor.moses')
local World  = require('lib.world')
local config = require('lib.config')
local fun    = require('vendor.fun')
local Branch = require('entities.branch')
local Ground = require('entities.ground')
local Player = require('entities.player')
local Trunk  = require('entities.trunk')

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
    local branches, bdefs = {}, {}
    fun.range(map.branches):each(function()
      local x = math.random(0, map.w-1)
      local y = gy[x+1]/tile.h - math.random(3,50)
      local len = math.random(4, 16)
      fun.range(0, len-1):each(function()
        x = x + 1
        y = y + sample(deltas)
        bdefs[x] = bdefs[x] or {}
        bdefs[x][y] = true
      end)
    end)
    for x, def in pairs(bdefs) do
      for y, _ in pairs(def) do
        table.insert(branches, Branch(x*tile.w, y*tile.h))
      end
    end

    -- Trunks
    local trunks, tdefs = {}, {}
    fun.range(map.trunks):each(function()
      local x = math.random(0, map.w-1)
      local y = gy[x+1]/tile.h
      local len = math.random(10, 50)
      fun.range(len):each(function()
        y = y - 1
        tdefs[x] = tdefs[x] or {}
        tdefs[x][y] = true
      end)
    end)
    for x, def in pairs(tdefs) do
      for y, _ in pairs(def) do
        table.insert(trunks, Trunk(x*tile.w, y*tile.h))
      end
    end

    return fun.chain(
      grounds,
      branches,
      trunks,
      {
        Player(-w/2, gy[1] - h)
      }
    )
  end

  return world
end

return Forest
