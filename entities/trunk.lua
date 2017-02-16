local config = require('lib.config')

local tile = config.tile

local function Trunk(x, y)
  return {
    bump = 'cross',
    minimap = true,
    pos = {
      x = x,
      y = y
    },
    size = {
      h = tile.h,
      w = tile.w
    },
    sprite = {
      r = 166,
      g = 104,
      b = 41
    },
    trunk = true,
    wrap = true,
    zIndex = 50
  }
end

return Trunk
