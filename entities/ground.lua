local config = require('lib.config')

local tile = config.tile

local function Ground(opts)
  return {
    bump = 'slide',
    ground = true,
    height = {
      l = opts.l,
      r = opts.r
    },
    minimap = true,
    position = {
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
    zIndex = 100
  }
end

return Ground
