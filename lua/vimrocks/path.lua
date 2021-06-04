local vi = require('vimrocks.vi')

local sep_cache
local function sep()
    -- cygwin? windows terminal?
    if sep_cache == nil then sep_cache = vi.is_windows() and '\\' or '/' end
    return sep_cache
end

local function join(parts) return vi.join(parts, sep()) end

-- 1 origin, inclusive
local function array_range(xs, from, to)
    local res = {}
    for i = 1, to do if from <= i then res[i - from + 1] = xs[i] end end
    return res
end

local function script_path()
    local str = debug.getinfo(1).source:sub(2)
    return str
end

local root_cache
local function root()
    if root_cache == nil then
        local this = script_path()
        local parts = vi.split(this, sep())
        local len = #parts
        root_cache = join(array_range(parts, 1, len - 3))
    end
    return root_cache
end

local function dest() return root() .. sep() .. 'dest' end

local function luaenv()
    local d
    if vi.is_nvim() then
        d = 'nvim_lua'
    else
        d = 'vim_lua'
    end
    local res = join {root(), 'dest', d}
    return res
end

local function luarocks() return join {luaenv(), 'bin', 'luarocks'} end

local function lualib(ver) return join {luaenv(), 'lib', 'lua', ver} end

return {
    sep = sep,
    root = root,
    dest = dest,
    join = join,
    luaenv = luaenv,
    luarocks = luarocks,
    lualib = lualib
}
