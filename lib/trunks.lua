local config = require('lib.config')
local Trunk  = require('entities.trunk')

local insert = table.insert
local random = math.random
local tile, map = config.tile, config.map

return function(ys)
  local stumps = {}
  local trunks = {}

  for _ = 1, map.trunks do
    stumps[random(1, #ys)] = true
  end

  for _, j in ipairs(keys(stumps)) do
    local x = (j - 1) * tile.w
    local y = min(ys[j], ys[j % #ys + 1])
    local len = random(10, 50)
    for k = 0, len-1 do
      insert(trunks, Trunk{ x = x, y = y - k * tile.h })
    end
  end

  return trunks
end
