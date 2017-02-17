local World   = require('lib.world')
local config  = require('lib.config')
local grounds = require('lib.grounds')
local Player  = require('entities.player')

local tile = config.tile

local function Forest()
  local world = World()

  function world.entities()
    local player = Player({ x = -tile.w, y = -tile.h })
    return concat(grounds(), { player })
  end

  return world
end

return Forest
