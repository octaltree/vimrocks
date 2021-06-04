" set verbose=1

let s:suite = themis#suite('compatibility')
let s:assert = themis#helper('assert')

function! s:suite.root_dir() abort
  let root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
  call s:assert.equals(luaeval("require('vimrocks').root_dir()"), root)
endfunction
