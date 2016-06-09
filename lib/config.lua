local jumpTime = 0.3

local tile = {
  h = 32,
  w = 32
}

return {
  camera = {
    window = {
      h = 6 * tile.h
    }
  },
  map = {
    w = 500 -- tiles
  },
  jump = {
    threshold = 100,
    vmin = -5 * tile.h / jumpTime,
    vmax = -7 * tile.h / jumpTime
  },
  physics = {
    g = 5 * tile.h / jumpTime^2
  },
  run = {
    dt   = 0.25,
    vmin = 250,
    vmax = 500
  },
  tile = tile
}
