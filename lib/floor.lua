local config = require('lib.config')

local insert = table.insert
local ceil, pi, random, sin = math.ceil, math.pi, math.random, math.sin

local width, tile = config.map.width, config.tile

local scale = 2 * pi / width

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
  local noise = genNoise()
  local ys = {}

  for x = 0, width - tile.w, tile.w do
    insert(ys, ceil(noise(scale * x) * 3) * tile.h)
  end

  return ys
end
