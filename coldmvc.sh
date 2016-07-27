#!/bin/sh -
# -----------------------------------------------------------
# ColdMVC
# -------
# Tooling to set up folders and whatnot for a new instance.
#
# 
# Commands
# --------
# - list instances
# - create a new instance
# - remove an instance
# - (registration is not needed b/c of how cf executes code...)
#
#
# Directory Layout
# ----------------
# app    - The application logic (you could write this ahead of time)
# assets - CSS, Javascript, static images, videos, etc.
# db     - Database files (ORM property stuff...)
# files  - Server writes files here
# sql    - SQL queries (should be part of properties probably)
# views  - View part of MVC.  HTML goes here
# -----------------------------------------------------------

PROGRAM=coldmvc
BINDIR="$(dirname "$(readlink -f $0)")"
SELF="$(readlink -f $0)"

usage () {
	STATUS=${1:-0}
	cat <<EOF
Usage: ./$PROGRAM
	[ -  ]

-c, --create <arg>            Create a new instance.
-r, --remove <arg>            Remove an instance.
-l, --list-instances          List info about instances.
-v, --verbose                 Be verbose in output.
-h, --help                    Show this help and quit.
EOF
	exit $STATUS
}

[ -z "$BASH_ARGV" ] && {
	printf "$PROGRAM: Nothing to do\n" > /dev/stderr
	usage 1
}

while [ $# -gt 0 ]
do
	case "$1" in
	-c|--create)
		DO_CREATE=1
		shift
		DIR="$1"
	;;
	-r|--remove)
		DO_REMOVE=1
	;;
	-l|--list-instances)
		DO_LIST=1
	;;
	-v|--verbose)	VERBOSE=true
	;;
	-h|--help)	usage 0
	;;
	--)	break
	;;
	-*)	printf "Unknown argument received: $1\n" > /dev/stderr; usage 1
	;;
	*)	break
	;;
	esac
	shift
done

#SRC=/etc/

# Let's see everything
printf "%30s: %s\n" "DIR" $DIR
printf "%30s: %s\n" "SRC" $SRC

# Set all that silly crap 
# OS options  - L = Linux, C = Cygwin, M = OSX, W = Windows
OS=1;
case $OS in
	'C') 
		;;
	'L')
		;;
	'M')
		;;
	'W')
		;;
esac

if [ ! -z $DO_LIST ]  
then 
#Configuration is in /etc.  More than likely a SQL db with your stuff...
printf "">2/dev/null
fi

# ???
if [ ! -z $DO_CREATE ]
then
	#Get the realpath
	DIR=`realpath $DIR`
	#Make all directories
	mkdir -p $DIR/{app,db,assets,files,sql,views} || echo "Failed to make new directory"
	#Link the framework files into the root of the new folder
	ln $SRC/Application.cfc $DIR/Application.cfc
	ln $SRC/4xx-view.css $DIR/4xx-view.css
	ln $SRC/5xx-view.css $DIR/5xx-view.css
	#Create data.json or data.cfm (probably data.json)
	#cp data.json data.json
	#Create ORM files (these can be done at any time)	
	#Create basic view files from some template somewhere
fi

if [ ! -z $DO_ORM ]
then
	# orm...
printf "">2/dev/null
fi


if [ ! -z $DO_REMOVE ] 
then 
printf "">2/dev/null
fi

