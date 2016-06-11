local config  = require('lib.config')
local machine = require('lib.statemachine')

local physics, run, tile = config.physics, config.run, config.tile

local function Player(x, y)
  return {
    bump = 'touch',
    camera = true,
    collision = {},
    controls = {},
    inputs = {
      actions = {
        jump = 'w',
        quit = 'escape'
      },
      states = {
        left  = 'a',
        right = 'd',
        turbo = '/'
      }
    },
    minimap = true,
    motion = {
      vx = 0,
      vy = 0,
      ax = 0,
      ay = physics.g
    },
    player = true,
    position = {
      x = x,
      y = y
    },
    size = {
      h = tile.h,
      w = tile.w
    },
    sprite = {
      r = 255,
      g = 0,
      b = 0
    },
    state = machine.create({
      initial = 'standing',
      events = {
        { name = 'jump', from = 'standing', to = 'jumping'  },
        { name = 'land', from = 'jumping',  to = 'standing' }
      }
    }),
    wrap = true,
    zIndex = 1000
  }
end

return Player
