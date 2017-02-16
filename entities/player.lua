local config  = require('lib.config')
local machine = require('vendor.statemachine')

local physics, tile = config.physics, config.tile

local function Player(opts)
  return {
    bump = 'touch',
    camera = true,
    collision = {},
    controls = {},
    inputs = {
      actions = {
        jump = 'k',
        quit = 'escape'
      },
      states = {
        up    = 'w',
        left  = 'a',
        down  = 's',
        right = 'd',
        turbo = ';'
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
    pos = {
      x = opts.x,
      y = opts.y
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
        {
          name = 'climb',
          from = { 'falling', 'standing' },
          to   = 'climbing'
        },
        {
          name = 'fall',
          from = { 'climbing', 'standing' },
          to   = 'falling'
        },
        {
          name = 'jump',
          from = { 'climbing', 'standing' },
          to   = 'falling'
        },
        {
          name = 'land',
          from = { 'falling', 'climbing' },
          to   = 'standing'
        }
      }
    }),
    wrap = true,
    zIndex = 1000
  }
end

return Player
