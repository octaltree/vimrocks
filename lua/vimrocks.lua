local vi = require('vimrocks.vi')

local sep_cache
local function sep()
    -- cygwin? windows terminal?
    if sep_cache == nil then sep_cache = vi.is_windows() and '\\' or '/' end
    return sep_cache
end

local function join(parts, s) return table.concat(parts, s) end

-- 1 origin, inclusive
local function array_range(xs, from, to)
    local res = {}
    for i = 1, to do if from <= i then res[i - from + 1] = xs[i] end end
    return res
end

local function root_dir()
    local this = debug.getinfo(1).short_src
    local parts = vi.split(this, sep())
    local len = #parts
    return join(array_range(parts, 1, len - 2), sep())
end

local function dest_dir() return root_dir() .. sep() .. 'dest' end

-- version number of (lua, jit)
local function lua_version()
    local j
    if jit and jit.version then
        j = vi.split(jit.version, ' ')[2]
    else
        j = nil
    end
    local v = vi.split(_VERSION, ' ')[2]
    return v, j
end

local function clean()
    local dest = vi.call('shellescape', dest_dir())
    vi.command('silent ! rm -rf ' .. dest)
end

return {root_dir = root_dir, lua_version = lua_version, clean = clean}
