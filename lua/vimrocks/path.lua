local vi = require('vimrocks.vi')

local sep_cache
local function sep()
    -- cygwin? windows terminal?
    if sep_cache == nil then sep_cache = vi.is_windows() and '\\' or '/' end
    return sep_cache
end

local function join(parts) return vi.join(parts, sep()) end

local dest_cache
local function dest()
    if dest_cache == nil then
        if vi.g 'vimrocks_dir' then
            local tmp = vi.call('expand', vi.g 'vimrocks_dir')
            local no_slash = tmp:gsub('/$', '')
            dest_cache = no_slash
        else
            local home = vi.call('expand', '~')
            local default = join {home, '.local', 'share', 'vimrocks'}
            dest_cache = default
        end
    end
    return dest_cache
end

local function luaenv()
    local d
    if vi.is_nvim() then
        d = 'nvim_lua'
    else
        d = 'vim_lua'
    end
    local res = join {dest(), d}
    return res
end

local function luarocks() return join {luaenv(), 'bin', 'luarocks'} end

local function lualib(ver) return join {luaenv(), 'lib', 'lua', ver} end

return {
    sep = sep,
    dest = dest,
    join = join,
    luaenv = luaenv,
    luarocks = luarocks,
    lualib = lualib
}
