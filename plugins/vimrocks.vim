let _ = exists('g:loaded_vimrocks') && finish
let g:loaded_vimrocks = 1

if get(g:, 'vimrocks#enable_at_startup', 0)
  lua require('vimrocks').append_path()
endif
