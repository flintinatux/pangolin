require('ext.index')
local Gamestate = require('lib.gamestate')
local Forest    = require('states.forest')

function love.load()
  require('assets.index')
  Gamestate.registerEvents()
  Gamestate.switch(Forest())
end
