local filter = {}

function filter.bump(e, other) return other.bump  end
function filter.debug(_, s)    return     s.debug end
function filter.draw(_, s)     return     s.draw  end
function filter.update(_, s)   return not s.draw  end

return filter
