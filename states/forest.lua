local World  = require('lib.world')
local config = require('lib.config')
-- local Branch = require('entities.branch')
local Ground = require('entities.ground')
local Player = require('entities.player')
-- local Trunk  = require('entities.trunk')

local insert = table.insert

local deltas = {0,0,0,0,0,0,0,0,0,0,1,-1}
local downs  = {0,0,0,0,0,0,0,0,0,0,1}
local ups    = {0,0,0,0,0,0,0,0,0,0,-1}
local width, tile = config.map.w, config.tile

local mirror = function(list)
  for i = #list, 1, -1 do
    insert(list, list[i])
  end
  return list
end

local sample = function(array)
  return array[math.random(1,#array)]
end

local function Forest()
  local world = World()

  function world.entities()
    local choices, delta
    local grounds, ys = {}, { 0 }

    for i = 2, width/2, 1 do
      choices = delta and (delta < 0 and ups or delta > 0 and downs) or deltas
      delta = sample(choices)
      ys[i] = ys[i-1] + delta * tile.h
    end

    ys = mirror(ys)

    for i = 1, #ys, 1 do
      local l, r = ys[i], ys[i % #ys + 1]
      local x = (i - 1) * tile.w
      local y = min(l, r)
      insert(grounds, Ground({ l = l, r = r, x = x, y = y }))
    end

    local player = Player({ x = -tile.w, y = -tile.h })
    return concat(grounds, { player })
  end

  return world
end

return Forest
