local jumpTime = 0.3

local tile = {
  h = 32,
  w = 32
}

return {
  camera = {
    xmin = love.graphics.getWidth()  / 2,
    ymax = love.graphics.getHeight() / 2
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
