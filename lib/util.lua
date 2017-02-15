local insert = table.insert

local assign, bind, compose, concat, identity, keys, mapreduce, min, max, path, prop, reduce

-- `({ s = a }, { s = a }) -> { s = a }`.
assign = function(a, b)
  for k, v in pairs(b) do
    a[k] = v
  end
  return a
end

-- `((a, b, ...) -> c, a) -> (b, ...) -> c`.
bind = function(f, ctx)
  return function(...)
    return f(ctx, ...)
  end
end

-- `((y -> z), ..., (a -> b)) -> a -> z`.
compose = function(...)
  local fs = {...}
  return function(...)
    local res = fs[#fs](...)
    for i = #fs-1, 1, -1 do
      res = fs[i](res)
    end
    return res
  end
end

-- `([a], [a]) -> [a]`.
concat = function(a, b)
  for _, v in ipairs(b) do
    insert(a, v)
  end
  return a
end

-- `a -> a`.
identity = function(...)
  return ...
end

-- `{ s = a } -> [s]`.
keys = function(obj)
  local res = {}
  for k in pairs(obj) do
    insert(res, k)
  end
  return res
end

-- `(b -> c, (a, c) -> a, a, [b]) -> a`.
mapreduce = function(f, g, init, list)
  for _, v in ipairs(list) do
    init = g(init, f(v))
  end
  return init
end

-- `(number, number) -> number`.
max = function(a, b)
  return a > b and a or b
end

-- `(number, number) -> number`.
min = function(a, b)
  return a < b and a or b
end

-- `[string] -> { s = a } -> a`.
path = function(ks)
  return function(obj)
    for _, k in ipairs(ks) do
      obj = obj[k]
    end
    return obj
  end
end

-- `string -> { s = a } -> a`.
prop = function(k)
  return function(obj)
    return obj[k]
  end
end

-- `((a, b) -> a, a, [b]) -> a`.
reduce = function(f, init, list)
  for _, v in ipairs(list) do
    init = f(init, v)
  end
  return init
end

local util = {
  assign    = assign,
  bind      = bind,
  compose   = compose,
  concat    = concat,
  identity  = identity,
  keys      = keys,
  mapreduce = mapreduce,
  max       = max,
  min       = min,
  path      = path,
  prop      = prop,
  reduce    = reduce
}

util.import = function(ctx)
  ctx = ctx or _G
  assign(ctx, util)
  return ctx
end

return util
