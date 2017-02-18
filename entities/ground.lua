local config = require('lib.config')

local tile = config.tile

local function Ground(opts)
  return {
    bump = 'cross',
    ground = true,
    height = {
      l = opts.l,
      r = opts.r
    },
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
      type = 'ground',
      r = 0,
      g = 255,
      b = 0
    },
    wrap = true,
    zIndex = 100
  }
end

return Ground
