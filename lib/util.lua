local util = {}

function util.bind(fn, self)
  return function(...)
    fn(self, ...)
  end
end

return util
