local vi = require('vimrocks.vi')
local path = require('vimrocks.path')

local function clean()
    local dest = vi.call('shellescape', path.dest())
    vi.command('silent ! rm -rf ' .. dest)
end
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

local function local_install_luarocks()
    local function e(s) return vi.call('shellescape', s) end
    local bin = path.join {path.dest(), 'py', 'bin'}
    local pip = path.join {bin, 'pip'}
    local hererocks = path.join {bin, 'hererocks'}
    vi.command('silent ! mkdir -p ' .. e(path.dest()))
    vi.command('! python -m venv ' .. e(path.join {path.dest(), 'py'}))
    vi.command('! ' .. e(pip) .. ' install hererocks')
    -- NOTE: vi.join space not work
    -- vi.command(sp {'!', e(pip), 'install', 'hererocks'})
    do
        local cmd = '! ' .. e(hererocks) .. ' -rlatest'
        local l, j = lua_version()
        if j then
            cmd = cmd .. ' -j' .. j
        else
            cmd = cmd .. ' -l' .. l
        end
        cmd = cmd .. ' ' .. e(path.luaenv())
        vi.command(cmd)
    end
end

local function luarocks_installed() return vi.filereadable(path.luarocks()) end

local function append_path()
    local ver, _ = lua_version()
    package.path = package.path .. ';' .. path.join {path.lualib(ver), '?.lua'}
    package.cpath = package.cpath .. ';' .. path.join {path.lualib(ver), '?.so'}
end

local function luarocks(args)
    local function e(s) return vi.call('shellescape', s) end
    vi.command('! ' .. e(path.luarocks()) .. ' ' .. args)
end

return {
    vi = vi,
    path = path,
    clean = clean,
    lua_version = lua_version,
    local_install_luarocks = local_install_luarocks,
    luarocks_installed = luarocks_installed,
    append_path = append_path,
    luarocks = luarocks
}
