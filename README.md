# luarocks-vim
Using luarocks assets for vim

## Requirements
* python >= 3.3
* vim if_lua or nvim lua

## Installation
for dein
```vim
call dein#add('octaltree/vimrocks')
```

## Usage
```vim
# install to {reporsitory}/dest/
lua require('vimrocks').local_install_luarocks()
# append local to package search path
lua require('vimrocks').append_path()

# install {reporsitory}/dest
lua require('vimrocks').run_luarocks("install luv")

lua <<EOF
local uv = require('luv')
EOF
```
