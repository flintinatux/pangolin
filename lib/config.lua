local jumpTime = 0.3

local tile = {
  h = 32,
  w = 32
}

return {
  camera = {
    window = {
      h = 6 * tile.h
    },
    x = {
      min = love.graphics.getWidth()/2
    },
    y = {
      max = love.graphics.getHeight()/2 + 2 * tile.h
    }
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
