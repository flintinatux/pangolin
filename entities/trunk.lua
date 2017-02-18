local config = require('lib.config')

local tile = config.tile

local function Trunk(opts)
  return {
    bump = 'cross',
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
      type = 'trunk',
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
