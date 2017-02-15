local s = require('vendor.squirrel_min')

exclude_files = { 'vendor/**/*.lua' }
globals = s.concat({ '_DEBUG', 'love' }, s.keys(s))
self = false
std = 'lua51'
unused_secondaries = false
