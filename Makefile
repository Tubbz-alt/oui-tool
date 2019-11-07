# -* makefile *-
#
# oui-tool - update and search IEEE OUI/IAB databases
# (c) 2018-2019 Vitaly Protsko <villy@sft.ru>
# Licensed under GPLv3

PREFIX  ?= /usr
SYSCONF ?= /etc/default
SYSTEMD  = /lib/systemd/system
DOCDIR  ?= $(PREFIX)/share/doc/oui-tool

INSTALL ?= install

INSTALL_FILE	= $(INSTALL) -p    -o root -g root -m 640
INSTALL_PROGRAM	= $(INSTALL) -p    -o root -g root -m 755
INSTALL_DIR	= $(INSTALL) -p -d -o root -g root -m 755

all build test:
	@echo "Nothing to do"

install: install-dir install-bin install-conf

install-dir:
	$(INSTALL_DIR) $(DESTDIR)$(PREFIX)/bin
	$(INSTALL_DIR) $(DESTDIR)$(PREFIX)/sbin
	$(INSTALL_DIR) $(DESTDIR)$(SYSCONF)/
	$(INSTALL_DIR) $(DESTDIR)$(SYSTEMD)/
	$(INSTALL_DIR) $(DESTDIR)$(DOCDIR)/
	$(INSTALL_DIR) $(DESTDIR)$(PREFIX)/share/ieee-data/

install-bin:
	$(INSTALL_PROGRAM) script/update-oui $(DESTDIR)$(PREFIX)/sbin/
	$(INSTALL_PROGRAM) script/ouilookup $(DESTDIR)$(PREFIX)/bin/
	ln -sf $(DESTDIR)$(PREFIX)/bin/ouilookup $(DESTDIR)$(PREFIX)/bin/oui

install-conf:
	$(INSTALL_FILE) conf/update-oui $(DESTDIR)$(SYSCONF)/
	$(INSTALL_FILE) conf/update-oui.cron $(DESTDIR)$(DOCDIR)/
	$(INSTALL_FILE) conf/update-oui.service $(DESTDIR)$(SYSTEMD)/
	$(INSTALL_FILE) conf/update-oui.timer $(DESTDIR)$(SYSTEMD)/

uninstall: uninstall-bin uninstall-data uninstall-conf

uninstall-bin:
	rm $(DESTDIR)$(PREFIX)/sbin/update-oui
	rm $(DESTDIR)$(PREFIX)/bin/ouilookup
	rm $(DESTDIR)$(PREFIX)/bin/oui

uninstall-conf:
	rm -rf $(DESTDIR)$(DOCDIR)
	rm -f $(DESTDIR)$(SYSTEMD)/update-oui.{service,timer}
	rm -f $(DESTDIR)$(SYSCONF)/update-oui


.PHONY: install-dir install-bin install-conf uninstall-bin uninstall-conf


# EOF oui-tool/Makefile
