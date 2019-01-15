# coldmvc - Makefile last updated 
PREFIX = /usr/local
SHAREDIR = $(PREFIX)/share
MANDIR = ${PREFIX}/share/man
BINDIR = $(PREFIX)/bin
CONFIG = /etc
WILDCARD=*
NAME=coldmvc


# list - List all the targets and what they do
list:
	@printf 'Available options are:\n'
	@sed -n '/^#/ { s/# //; 1d; p; }' Makefile | awk -F '-' '{ printf "  %-20s - %s\n", $$1, $$2 }'

# install - Install the ColdMVC package on a new system
install:
	-test -d $(PREFIX) || mkdir -p $(PREFIX)/{share,share/man,bin}/
	-mkdir -p $(PREFIX)/share/$(NAME)/
	-cp ./$(NAME) $(PREFIX)/bin/$(NAME)
	-cp -r ./share/$(WILDCARD) $(PREFIX)/share/$(NAME)/
	-cp ./$(NAME).cfc $(PREFIX)/share/$(NAME)/
	-cp ./etc/$(NAME).conf $(CONFIG)/
	-sed -i 's;__PREFIX__;$(PREFIX);' $(CONFIG)/$(NAME).conf 

# uninstall - Uninstall the ColdMVC package on a new system
uninstall:
	-rm -f $(PREFIX)/bin/$(NAME)
	-rm -f $(CONFIG)/$(NAME).conf
	-rm -rf $(PREFIX)/share/$(NAME)/

#if 0 
# pkg - Create new packages for distribution
pkgMakefile:
	@sed '/^# /d' Makefile | cpp - | sed '/^# /d'

pkg:
	git archive master HEAD | tar czf - > /tmp/$(NAME).`date +%F`.`date +%H-%M-%S`.tar.gz

#endif
