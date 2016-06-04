local Gamestate = require('lib.gamestate')
local Level01   = require('states.level-01')

function love.load()
  require('assets.index')
  Gamestate.registerEvents()
  Gamestate.switch(Level01())
end
