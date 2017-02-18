require('lib.util').import()
math.randomseed(os.time())
love.mouse.setVisible(false)

local Gamestate = require('vendor.gamestate')
local Forest    = require('states.forest')

function love.load()
  require('assets.index')
  Gamestate.registerEvents()
  Gamestate.switch(Forest())
end
