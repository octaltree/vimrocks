" set verbose=1

let s:suite = themis#suite('compatibility')
let s:assert = themis#helper('assert')

function! s:suite.root_dir() abort
  let root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
  call s:assert.equals(luaeval("require('vimrocks.path').root()"), root)
endfunction

function! s:suite.local_install_luarocks() abort
  lua require('vimrocks').local_install_luarocks()
  let luaenv = luaeval("require('vimrocks.path').luaenv()")
  let sep = luaeval("require('vimrocks.path').sep()")
  call s:assert.equals(filereadable(luaenv . sep . 'bin' . sep . 'luarocks'), 1)
endfunction
