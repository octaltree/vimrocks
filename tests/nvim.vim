" set verbose=1

let s:suite = themis#suite('nvim')
let s:assert = themis#helper('assert')

function! s:suite.is_nvim() abort
  call s:assert.equals(luaeval("require('vimrocks.vi').is_nvim()"), 1)
endfunction
