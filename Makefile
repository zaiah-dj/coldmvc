# Build variables
ARCHIVEDIR=..
ARCHIVEFMT = gz
LDDIRS = -L$(PREFIX)/lib
LDFLAGS =
SHARED_LDFLAGS =
CC = gcc
PREFIX = /usr/local
SHAREDIR = $(PREFIX)/share
MANDIR = ${PREFIX}/share/man
BINDIR = $(PREFIX)/bin
CONFIG = /etc

# Program variables
NAME = coldmvc
IGNORE = archive
ARCHIVEDIR = ..
ARCHIVEFILE = $(NAME).`date +%F`.`date +%H.%M.%S`.tar.${ARCHIVEFMT}

.PHONY: all clean debug echo


main:
	@echo javac coldmvc.java
	@javac coldmvc.java

run:
	@java CLI 


pkg:
	git archive master HEAD | tar czf - > /tmp/$(NAME).`date +%F`.`date +%H-%M-%S`.tar.gz

# Probably should be root
install:
	-test -d $(PREFIX) || mkdir -p $(PREFIX)/{share,share/man,bin}/
	-mkdir -p $(PREFIX)/share/$(NAME)/
	-cp ./$(NAME) $(PREFIX)/bin/$(NAME)
	-cp ./share/*.cfm $(PREFIX)/share/$(NAME)/
	-cp ./etc/$(NAME).conf $(CONFIG)/
	-sed -i 's;__PREFIX__;$(PREFIX);' $(CONFIG)/$(NAME).conf 

# install man pages at some point, for the tool really

# ...
#	-sqlite3 $(CONFIG)/$(NAME)_config.db < populate.sql

# would really like to publish my changelogs too, could just be a hook
#changelog:
#	-printf ''>/dev/null		

uninstall:
	-rm -f $(PREFIX)/bin/$(NAME)
	-rm -f $(CONFIG)/$(NAME).conf
	-rm -rf $(PREFIX)/share/$(NAME)/

# Version control
commit:
	git commit

clean:
	-find . -type f -iname "*.o" | xargs rm
	-find . -type f -iname "*.a" | xargs rm
	-find . -type f -iname "*.$(SONAME)" | xargs rm
	-find . -type f -iname "*.exe" | xargs rm
	-find . -type f -iname "*.stackdump" | xargs rm
	-find . -type f -iname "*-tests" | xargs rm
	-find . -type f -iname ".*.swp" | xargs rm

permissions:
	@find | grep -v './tools' | grep -v './examples' | grep -v './.git' | sed '1d' | xargs stat -c 'chmod %a %n' > PERMISSIONS

restore-permissions:
	chmod 744 PERMISSIONS
	./PERMISSIONS
	chmod 644 PERMISSIONS

backup:
	@echo tar chzf $(ARCHIVEDIR)/${ARCHIVEFILE} --exclude-backups \
		`echo $(IGNORE) | sed '{ s/^/--exclude=/; s/ / --exclude=/g; }'` ./*
	@tar chzf $(ARCHIVEDIR)/${ARCHIVEFILE} --exclude-backups \
		`echo $(IGNORE) | sed '{ s/^/--exclude=/; s/ / --exclude=/g; }'` ./*

dist:
	@echo tar chzf $(ARCHIVEDIR)/${ARCHIVEFILE} --exclude-backups \
		`echo $(IGNORE) | sed '{ s/^/--exclude=/; s/ / --exclude=/g; }'` ./*
	@tar chzf $(ARCHIVEDIR)/${ARCHIVEFILE} --exclude-backups \
		`echo $(IGNORE) | sed '{ s/^/--exclude=/; s/ / --exclude=/g; }'` ./*
	

archive: ARCHIVEDIR = archive
archive: backup


# Create the examples directory
mkdir-examples:
	echo
