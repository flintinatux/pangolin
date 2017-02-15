require('lib.util').import()
require('ext.index')
local Gamestate = require('vendor.gamestate')
local Forest    = require('states.forest')

function love.load()
  require('assets.index')
  Gamestate.registerEvents()
  Gamestate.switch(Forest())
end
