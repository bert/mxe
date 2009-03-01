# pixman
# http://cairographics.org/

PKG            := pixman
$(PKG)_VERSION := 0.14.0
$(PKG)_SUBDIR  := pixman-$($(PKG)_VERSION)
$(PKG)_FILE    := pixman-$($(PKG)_VERSION).tar.gz
$(PKG)_URL     := http://cairographics.org/releases/$($(PKG)_FILE)
$(PKG)_DEPS    := gcc

define $(PKG)_UPDATE
    wget -q -O- 'http://cairographics.org/releases/' | \
    grep 'LATEST-pixman-' | \
    $(SED) -n 's,.*"LATEST-pixman-\([0-9][^"]*\)".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef