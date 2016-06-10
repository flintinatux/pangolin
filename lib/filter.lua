local tiny = require('lib.tiny')

local filter = {}

filter.all = tiny.requireAll

function filter.bump(e, o)
  return type(o.bump) == 'function' and o.bump(e, o) or o.bump
end

function filter.by(key)
  return function(_, t)
    t = t or _
    return t[key]
  end
end

function filter.platform(e, o)
  local falling = e.motion.vy > 0 and e.position.y + e.size.h <= o.position.y
  return falling and 'slide' or 'cross'
end

return filter
