local fun = require('lib.fun')

local colors = {
  red    = -2,
  pink   = -1,
  white  =  0,
  blue   =  1,
  violet =  2
}

local freqs = fun.range(30) -- fun.range(0.1, 3.0, 0.1)

local function amplitude(color, freq)
  return freq^colors[color]
end

local function noise(freq)
  local phase = 2 * math.pi * math.random()
  return function(x)
    return math.sin(2 * math.pi * freq * x + phase)
  end
end

local function smooth(a, b)
  return (a + b) / 2
end

local function weightedSum(x)
  return function(sum, wt, fn)
    return sum + wt * fn(x)
  end
end

local function Terrain()
  math.randomseed(os.time())
  local amplitudes = fun.zip(fun.duplicate('red'), freqs):map(amplitude)
  local noises = fun.zip(amplitudes, freqs:map(noise))

  return function(x)
    return noises:reduce(weightedSum(x), 0)
  end
end

return Terrain
