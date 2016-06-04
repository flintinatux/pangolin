local tiny = require('lib.tiny')

local function Text()
  local system = tiny.processingSystem({ draw = true })

  system.filter = tiny.requireAll('text')

  function system:process(e, dt)
    love.graphics.print(e.text.content, 400, 200)
  end

  return system
end

return Text
