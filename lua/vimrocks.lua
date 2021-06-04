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
    vi.command('! mkdir -p ' .. e(path.dest()))
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

return {
    lua_version = lua_version,
    clean = clean,
    local_install_luarocks = local_install_luarocks
}
