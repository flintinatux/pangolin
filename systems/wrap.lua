local config = require('lib.config')
local tiny   = require('lib.tiny')

local map = config.map

local function Wrap(world)
  local system  = tiny.processingSystem()
  system.filter = tiny.requireAll('wrap')
  local player

  function system:onAdd(e)
    if e.player then player = e end
  end

  function system:process(e)
    local ex, ey, px = e.position.x, e.position.y, player.position.x

    if ex < px - map.w/2 then
      world.move(e, ex + map.w, ey, true)
    elseif ex > px + map.w/2 then
      world.move(e, ex - map.w, ey, true)
    end
  end

  return system
end

return Wrap
