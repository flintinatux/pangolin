local World  = require('lib.world')
local config = require('lib.config')
-- local Branch = require('entities.branch')
local Ground = require('entities.ground')
local Player = require('entities.player')
-- local Trunk  = require('entities.trunk')

local insert = table.insert
local pi, random, sin = math.pi, math.random, math.sin

local width, tile = config.map.width, config.tile

local factor = function()
  return random(-0.5, 0.5)
end

local genNoise = function()
  local a, b, c, d, e = factor(), factor(), factor(), factor(), factor()
  return function(x)
    return a*sin(x) + b*sin(2*x) + c*sin(4*x) + d*sin(8*x) + e*sin(16*x)
  end
end

local function Forest()
  local world = World()

  function world.entities()
    local scale = 2 * pi / width
    local noise = genNoise()
    local grounds, ys = {}, {}

    for x = 0, width - tile.w, tile.w do
      insert(ys, noise(scale * x) * 3 * tile.h)
    end

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
