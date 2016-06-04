local config = require('lib.config')

local tile = config.tile

local function Ground(x, y)
  return {
    bump = 'slide',
    ground = true,
    position = {
      x = x,
      y = y
    },
    size = {
      h = tile.h,
      w = tile.w
    },
    sprite = {
      r = 0,
      g = 255,
      b = 0
    }
  }
end

return Ground
