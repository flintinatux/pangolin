local jumpTime = 0.3

local tile = {
  h = 32,
  w = 32
}

return {
  jump = {
    vmin = -5 * tile.h / jumpTime,
    vmax = -7 * tile.h / jumpTime
  },
  physics = {
    g = 5 * tile.h / jumpTime^2
  },
  run = {
    a    = 2500,
    vmin = 250,
    vmax = 500
  },
  tile = tile
}
