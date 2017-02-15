DEV_ROCKS = inspect luacheck

build:
	@love .

dev:
	@for rock in $(DEV_ROCKS) ; do \
		if ! luarocks list | grep $$rock > /dev/null ; then \
      echo $$rock not found, installing via luarocks... ; \
      luarocks install $$rock ; \
    else \
      echo $$rock already installed, skipping ; \
    fi \
	done;

lint:
	@luacheck -q .
