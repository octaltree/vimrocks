local function has(name) return vim.fn.has(name) == 1 end

local is_nvim_cache
local function is_nvim()
    if is_nvim_cache == nil then is_nvim_cache = has('nvim') end
    return is_nvim_cache
end

local is_windows_cache
local function is_windows()
    if is_windows_cache == nil then is_windows_cache = has('win32') end
    return is_windows_cache
end

local function g(name)
    if is_nvim() then
        return vim.g[name]
    else
        return vim.eval('g:' .. name)
    end
end

local function command(s)
    if is_nvim() then
        vim.api.nvim_command(s)
    else
        vim.command(s)
    end
end

local function call(...) return vim.call(...) end

local function split(s, sep)
    if is_nvim() then return vim.split(s, sep) end
    local res = {}
    for w in string.gmatch(s, '[^' .. sep .. ']*') do table.insert(res, w); end
    return res
end

return {
    is_nvim = is_nvim,
    is_windows = is_windows,
    g = g,
    command = command,
    call = call,
    split = split
}
