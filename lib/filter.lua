local tiny = require('lib.tiny')

local filter = {}

filter.all = tiny.requireAll

function filter.by(key)
  return function(_, t)
    t = t or _
    return t[key]
  end
end

return filter
