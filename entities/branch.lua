local config = require('lib.config')
local filter = require('lib.filter')

local tile = config.tile

local function Branch(opts)
  return {
    bump = 'cross', --filter.platform,
    minimap = true,
    pos = {
      x = opts.x,
      y = opts.y
    },
    size = {
      h = tile.h,
      w = tile.w
    },
    sprite = {
      r = 0,
      g = 255,
      b = 0
    },
    wrap = true,
    zIndex = 200
  }
end

return Branch
