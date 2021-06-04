" set verbose=1

let s:suite = themis#suite('compatibility')
let s:assert = themis#helper('assert')

function! s:suite.version_is_not_nil() abort
  " only first value
  let is_not_nil = luaeval("require('vimrocks').lua_version() ~= nil")
  call s:assert.true(is_not_nil)
endfunction

function! s:suite.root_dir() abort
  let root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
  call s:assert.equals(luaeval("require('vimrocks.path').root()"), root)
endfunction

function! s:suite.local_install_luarocks() abort
  lua require('vimrocks').local_install_luarocks()
  let luarocks = luaeval("require('vimrocks.path').luarocks()")
  call s:assert.true(filereadable(luarocks))
endfunction

function! s:suite.basic_usage() abort
  " NOTE: after local_install_luarocks
  lua require('vimrocks').append_path()
  lua require('vimrocks').run_luarocks("install luv")
  let dest = luaeval("require('vimrocks.path').dest()")
  let sep = luaeval("require('vimrocks.path').sep()")
  let file = dest . sep . 'hoge'
  call s:assert.false(filereadable(file))
  lua <<EOF
    local path = require('vimrocks.path')
    local file = path.join{path.dest(), 'hoge'}
    require('luv').spawn('touch', {file})
EOF
  call s:assert.true(filereadable(file))
  execute 'silent ! rm ' . shellescape(file)
endfunction
