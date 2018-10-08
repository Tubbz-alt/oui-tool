# -* makefile *-
#
#

PREFIX ?= /usr
# LIBEXEC ?= /var/lib
SYSCONF ?= /etc
INSTALL ?= install

#INSTALL_FILE	= $(INSTALL) -p    -o root -g root -m 640
INSTALL_DATA	= $(INSTALL) -p    -o root -g root -m 644
INSTALL_PROGRAM	= $(INSTALL) -p    -o root -g root -m 755
INSTALL_SCRIPT	= $(INSTALL) -p    -o root -g root -m 755
INSTALL_DIR	= $(INSTALL) -p -d -o root -g root -m 755

all build test:
	@echo "Nothing to do"

install: install-dir install-bin install-conf

install-dir:
	$(INSTALL_DIR) $(DESTDIR)$(SYSCONF)/cron.weekly/
	$(INSTALL_DIR) $(DESTDIR)/share/ieee-data/

install-bin:
	$(INSTALL_DIR) $(DESTDIR)$(PREFIX)/bin
	$(INSTALL_PROGRAM) script/update-oui $(DESTDIR)$(PREFIX)/sbin/
	$(INSTALL_PROGRAM) script/ouilookup $(DESTDIR)$(PREFIX)/bin/
	ln -sf $(DESTDIR)$(PREFIX)/bin/ouilookup $(DESTDIR)$(PREFIX)/bin/oui

install-conf:
	$(INSTALL_PROGRAM) script/update-oui.cron $(DESTDIR)$(SYSCONF)/cron.weekly/

uninstall: uninstall-bin uninstall-data uninstall-conf

uninstall-bin:
	rm $(DESTDIR)$(PREFIX)/sbin/update-oui
	rm $(DESTDIR)$(PREFIX)/bin/ouilookup
	rm $(DESTDIR)$(PREFIX)/bin/oui

uninstall-conf:
	rm -f $(DESTDIR)$(SYSCONF)/cron.weekly/update-oui.cron

uninstall-data:
	rm -rf $(DESTDIR)/share/ieee-data


.PHONY: install-dir install-bin install-data uninstall-bin uninstall-data


# EOF oui-tool/Makefile
