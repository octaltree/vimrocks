.PHONY: clean
clean:
	rm -rf dest

.PHONY: dev
dev: lua-format lua-lint test

.PHONY: d
d:
	watchexec 'make lua-lint test'

# https://github.com/Koihik/LuaFormatter
.PHONY: lua-format
lua-format:
	find lua -name "*.lua"| xargs lua-format -i

# https://github.com/mpeterv/luacheck
.PHONY: lua-lint
lua-lint:
	@find lua -name "*.lua"| xargs luacheck -q |\
		sed '/accessing undefined variable \[0m\[1mvim/d' |\
		sed '/unused argument \[0m\[1m_/d' |\
		sed '/^$$/d' |\
		sed 's/\[0m\[31m\[1m[0-9]\+ warnings\[0m//g'|\
		sed '/^Total:/d'

export THEMIS_HOME := ./dest/vim-themis

.PHONY: test
test: dest/vim-themis
	THEMIS_VIM=vim THEMIS_ARGS="-e -s" dest/vim-themis/bin/themis tests/{compatibility,vim}.vim
	THEMIS_VIM=nvim THEMIS_ARGS="-e -s --headless" dest/vim-themis/bin/themis tests/{compatibility,nvim}.vim

dest/vim-themis:
	mkdir -p dest
	git clone https://github.com/thinca/vim-themis $@

dest:
	mkdir -p $@

# vim: foldmethod=marker
