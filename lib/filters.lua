local filters = {}

function filters.bump(e, other) return other.bump end

function filters.debug(_, s) return s.debug end

function filters.draw(_, s) return s.draw  end

function filters.ground(e) return e.ground end

function filters.update(_, s) return not s.draw end

return filters
