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
lua <<EOF
local vimrocks = require('vimrocks')

if not vimrocks.luarocks_installed() then
  " install luarocks to {repository}/dest/
  vimrocks.local_install_luarocks()
end

" append local to package search path
vimrocks.append_path()

" Use the library
vimrocks.run_luarocks('install luv')
local uv = require('luv')
local params = {args = {'/tmp/hoge'}}
uv.spawn('touch', params)
EOF
```
