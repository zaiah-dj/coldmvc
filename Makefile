# cold-mvc 
include config.mk
NAME = coldmvc
SRC = coldmvc.c opt.c lite.c
OBJ = ${SRC:.c=.o}
IGNORE = coldmvc www/*
ARCHIVEDIR = ..
ARCHIVEFILE = $(NAME).`date +%F`.`date +%H.%M.%S`.tar.${ARCHIVEFMT}

.PHONY: all clean debug echo

coldmvc: ${OBJ}
	@echo CC -o $@ ${OBJ} ${CFLAGS}
	@${CC} -o $@ ${OBJ} ${CFLAGS}

#sqlite3.o: CFLAGS = -O2 -DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_RTREE 
#sqlite3.o:
#	@echo CC -o sqlite3.o sqlite3.c ${CFLAGS}
#	@${CC} -o sqlite3.o sqlite3.c ${CFLAGS}
#	@echo CC -o sqlite3.o sqlite3.c -O2 -DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_RTREE
#	@${CC} -o sqlite3.o sqlite3.c -O2 -DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_RTREE 

	
install:
	-test -d $(PREFIX) || mkdir $(PREFIX)
	-test -d $(SHARE) || mkdir $(SHARE)
	-cp ./bin/$(NAME).sh $(PREFIX)/bin/$(NAME)
	-cp ./share/*.cfm $(PREFIX)/share
	-cp ./etc/$(NAME).conf $(CONFIG)/
#	-sqlite3 $(CONFIG)/$(NAME)_config.db < populate.sql

changelog:
	-printf ''>/dev/null		

uninstall:
	-rm -f $(PREFIX)/include/$(NAME).h
	-rm -rf $(PREFIX)/include/$(NAME)

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
