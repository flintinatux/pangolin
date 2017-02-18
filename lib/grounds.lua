local config = require('lib.config')
local Ground = require('entities.ground')

local insert = table.insert
local ceil, pi, random, sin = math.ceil, math.pi, math.random, math.sin

local width, tile = config.map.width, config.tile

local factor = function()
  return random(-0.2, 0.2)
end

local genNoise = function()
  local a, b, c, d, e = factor(), factor(), factor(), factor(), factor()
  return function(x)
    return a*sin(x) + b*sin(2*x) + c*sin(4*x) + d*sin(8*x) + e*sin(16*x)
  end
end

return function()
  local scale = 2 * pi / width
  local noise = genNoise()
  local grounds, ys = {}, {}

  for x = 0, width - tile.w, tile.w do
    insert(ys, ceil(noise(scale * x) * 3) * tile.h)
  end

  for i = 1, #ys, 1 do
    local l, r = ys[i], ys[i % #ys + 1]
    local x = (i - 1) * tile.w
    local y = min(l, r)
    insert(grounds, Ground({ l = l, r = r, x = x, y = y }))
  end

  return grounds
end
