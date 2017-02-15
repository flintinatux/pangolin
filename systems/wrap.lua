local config = require('lib.config')
local tiny   = require('vendor.tiny')

local map, tile = config.map, config.tile
local width = map.w * tile.w

local function Wrap(world)
  local system  = tiny.processingSystem({ update = true })
  system.filter = tiny.requireAll('wrap')
  local player

  function system:onAdd(e)
    if e.player then player = e end
  end

  function system:process(e)
    local ex, ey, px = e.position.x, e.position.y, player.position.x

    if ex < px - width/2 then
      world.move(e, ex + width, ey, true)
    elseif ex > px + width/2 then
      world.move(e, ex - width, ey, true)
    end
  end

  return system
end

return Wrap
