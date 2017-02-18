local World    = require('lib.world')
local branches = require('lib.branches')
local config   = require('lib.config')
local floor    = require('lib.floor')
local grounds  = require('lib.grounds')
local trunks   = require('lib.trunks')
local Player   = require('entities.player')

local tile = config.tile

local function Forest()
  local world = World()

  function world.entities()
    local ys = floor()
    local player = Player({ x = -tile.w, y = -tile.h })

    local ents = flatten({
      branches(ys),
      grounds(ys),
      trunks(ys),
      { player }
    })

    print(string.format('ents: %s', #ents))
    return ents
  end

  return world
end

return Forest
