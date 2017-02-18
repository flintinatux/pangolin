local jumpTime = 0.3

local tile = {
  h = 32,
  w = 32
}

local tilesWide  = 500
local trunkRatio = 0.05

return {
  camera = {
    window = {
      h = 6 * tile.h
    }
  },
  climb = {
    v = 150
  },
  map = {
    branches  = 150,
    tilesWide = tilesWide,
    trunks    = tilesWide * trunkRatio,
    width     = tilesWide * tile.w
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
