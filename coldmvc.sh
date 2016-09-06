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
#
#
# Aliases (to test building example instances)
# --------------------------------------------
#
# #Some aliases to get this thing to run correctly
# function mkv ( ) {
# 	APP=$1
# 	[ -z "$APP" ] && { printf "No instance name specified.\n" 2>/dev/null; return; }
# 	./coldmvc.sh -c $HOME/www/$APP
# 	ln -s $HOME/www/$APP $HOME/prj/coldmvc/examples/$APP 
# 	echo "Instance created at $HOME/www/$APP."
# }
# 
# 
# function rmv ( ) {
# 	APP=$1
# 	[ -z "$APP" ] && { printf "No instance name specified.\n" 2>/dev/null; return; }
# 	rm -rf $HOME/www/$APP $HOME/prj/coldmvc/examples/$APP 
# 	echo "Instance $HOME/www/$APP removed."
# }
# -----------------------------------------------------------

PROGRAM=coldmvc
BINDIR="$(dirname "$(readlink -f $0)")"
SELF="$(readlink -f $0)"

die () {
	printf "$PROGRAM error: $1"	>/dev/stderr
	exit $STATUS
}


usage () {
	STATUS=${1:-0}
	cat <<EOF
Usage: ./$PROGRAM
	[ -  ]

-c, --create <arg>            Create a new instance.
-r, --remove <arg>            Remove an instance.
-l, --list-instances          List info about instances.
-t, --root-dir                Create a root directory.
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
	-d|--datasource)
		shift
		DATASOURCE="$1"
	;;
	-t|--rootdir)
		shift
		ROOTDIR="$1"
	;;
	-n|--name)
		shift
		NAME="$1"
	;;
	-u|--update)
		DO_UPDATE=1
		shift
		DIR="$1"
	;;
	-r|--remove)
		DO_REMOVE=1
		shift
		DIR="$1"
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

SRC="/share"
SRC="./share"

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
	#Die if no $DIR was specified.
	[ -z $DIR ] && die "No directory specified."
	#[ ${DIR:0:1} != '/' ] && [ ! -d `dirname $DIR` ] && die "Source directory does not exist."
	#[ ${DIR:0:1} == '/' ] && [ ! -d $DIR ] && die "Source directory does not exist."

	#Also die if no ROOTDIR was specified.
	[ -z $ROOTDIR ] && die "No root directory specified." 

	#Also die if no ROOTDIR was specified.
	#[ -z $NAME ] && die "No root directory specified." 
	DATASOURCE=${DATASOURCE:-""}

	#Get the realpath
	DIR=`realpath $DIR`

	#Set a name
	if [ ! -z $NAME ] 
	then
		NAME=`basename $DIR`
	fi

	#Make all directories
	mkdir -p $DIR/{app,assets,db,files,sql,std,views} || echo "Failed to make new directory"

	#Copy the framework files into the root of the new folder. (should have been links)
	ln $SRC/coldmvc.cfc $DIR/coldmvc.cfc

	#Copy the rest of these because they may be heavily modified.
	#cp $SRC/5xx-view.css $DIR/5xx-view.css
	cp $SRC/Application.cfc $DIR/Application.cfc
	cp $SRC/{failure,index}.cfm $DIR/
	cp $SRC/{4xx,5xx}-view.css $DIR/
	cp $SRC/{4xx,5xx,admin,html,mime}-view.cfm $DIR/std/
	touch $DIR/{app,views}/default.cfm

	#Create data.json or data.cfm (probably data.json)
	touch $DIR/data.json
	[ ! -z $LOAD_JSON ] && [ ! -f $JSON ] && die "JSON not specified." 
	if [ ! -z $LOAD_JSON ]
	then
		printf "" > /dev/null
		#Create resource files

		#Create ORM files (these can be done at any time)	

		#Create basic view files from some template somewhere
	else
		#Set up the data file after setup.
		cp $SRC/data.json $DIR/data.json
		sed -i "{ s#<name>#$NAME#; s#<web>#$ROOTDIR#; s#<datasource>#$DATASOURCE#; }" $DIR/data.json
	fi
fi


if [ ! -z $DO_ORM ]
then
	# orm...
printf "">2/dev/null
fi


if [ ! -z $DO_REMOVE ] 
then 
	rm -rf $DIR
fi

