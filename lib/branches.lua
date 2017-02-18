local Branch = require('entities.branch')
local config = require('lib.config')

local insert = table.insert
local random = math.random
local tile, map = config.tile, config.map

local deltas = {0,0,0,0,0,0,0,0,0,0,1,-1}

return function(ys)
  local branches = {}

  for i = 1, map.branches do
    local j = random(1, map.tilesWide)
    local x = (j - 1) * tile.w
    local y = min(ys[j], ys[j % #ys + 1]) - random(3, 50) * tile.h
    local len = random(4, 16)
    for k = 0, len-1 do
      insert(branches, Branch({ x = x + k * tile.w, y = y }))
      y = y + sample(deltas) * tile.h
    end
  end

  return branches
end
