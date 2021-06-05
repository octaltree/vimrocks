# luarocks-vim
Using luarocks assets for vim

## Requirements
* python >= 3.3
* vim if_lua or nvim lua

## Installation
For dein
```vim
call dein#add('octaltree/vimrocks')
```

## Usage
For nvim and vim
```vim
" append local to package search path at start
let g:vimrocks#enable_at_start = 1

lua <<EOF
local vimrocks = require('vimrocks')
if not vimrocks.luarocks_installed() then
  vimrocks.local_install_luarocks()
end

" Use the library
vimrocks.luarocks('install luv')
local uv = require('luv')
local params = {args = {'/tmp/hoge'}}
uv.spawn('touch', params)
EOF
```
