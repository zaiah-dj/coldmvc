#!/bin/bash -
# -------------------------------------------- #
# coldmvc.sh
#
# @author
#		Antonio R. Collins II (ramar.collins@gmail.com)
# @end
#
# @copyright
# 	Copyright 2016-Present, "Deep909, LLC"
# 	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
# @end
# 
# @summary
# 	An administration interface for ColdMVC sites.
# @end
#
# @usage
# 	
# @end
#
# @body
#  
# @end
# 
# @todo
#		- Be able to build from JSON
# 	- Handle setup tasks and tooling ( like database connections and maintenance ) 
# 	- Convert to Java or C++
# @end
# -------------------------------------------- #

DIR=$HOME/prj/www-lucee/$DEV_DOMAIN

# Process any options
while [ $# -gt 0 ]
do
	case "$1" in
		-f|--folder)
			shift
			DIR="$1"
		;;

		-n|--name)
			shift
			NAME="$1"	
		;;

		-m|--domain)
			shift
			DOMAIN="$1"	
		;;

		-l|--list)
			ACTION="l"
		;;

		-d|--description)
			shift
			DESCRIPTION="$1"	
		;;

		-h|--hh)
			ACTION="h"
			shift
			TYPE="$1"	
		;;

		-v|--verbose)	
			VERBOSE=true
		;;

		--help)	
			usage 0
		;;

		--)	break
		;;

		-*)	printf "Unknown argument received: $1\n" > /dev/stderr; usage 1
		;;
	esac
	shift
done

# Set up a new CMVC instance
[ $VERBOSE -eq 1 ] && printf "Creating new ColdMVC instance...\n"
mkdir -p $DIR/{app,assets,db,files,log,share,std,views}



# Can you ping?  If so, clone it from Github
if [ 0 -eq 1 ]
then 
	REPO=https://github.com/zaiah-dj/coldmvc.git
	CURR=$DIR/coldmvc-tmp
	git clone $REPO $CURR
# If not, do something else
else
	CURR=$HOME/prj/coldmvc
fi

# Populate the new thing
[ $VERBOSE -eq 1 ] && printf "Populating new ColdMVC instance...\n"
cp $CURR/share/{Application.cfc,coldmvc.cfc,index.cfm,data.json} $DIR/
cp $CURR/share/data.json.example $DIR/std/
#cp $CURR/share/apache_htaccess $DIR/.htaccess
cp $CURR/share/app-default.cfm $DIR/app/default.cfm
cp $CURR/share/views-default.cfm $DIR/views/default.cfm
cp $CURR/share/{4xx-view,5xx-view,failure,mime-view,html-view,admin-view}.cfm $DIR/std/
cp $CURR/share/Application-Redirect.cfc $DIR/app/Application.cfc
cp $CURR/share/Application-Redirect.cfc $DIR/db/Application.cfc
cp $CURR/share/Application-Redirect.cfc $DIR/files/Application.cfc
cp $CURR/share/Application-Redirect.cfc $DIR/std/Application.cfc
cp $CURR/share/Application-Redirect.cfc $DIR/views/Application.cfc
cp $CURR/share/*.css $DIR/assets/
touch $DIR/{Makefile,README.md} 
[ -d $DIR/coldmvc-tmp ] && rm -rf $DIR/coldmvc-tmp

# Modify the data.json in the new directory to actually work
sed -i "{
	s/DATASOURCE/(none)/
	s;COOKIE;`xxd -ps -l 60 /dev/urandom | head -n 1`;
	s;BASE;/;
	s/NAME/$DEV_DOMAIN/
	s/TITLE/${DEV_DOMAIN%%.local}/
}" $DIR/data.json

#Add a changelog
[ $VERBOSE -eq 1 ] && printf "Generating a CHANGELOG file...\n"
printf "`date +%F`\n\t- Created this project." > $DIR/CHANGELOG

#Add a README
[ $VERBOSE -eq 1 ] && printf "Generating a README file...\n"
printf "Give me a short description of this project.\n(Press [Ctrl-D] to save this file...)\n"
touch $DIR/README.md
cat > $DIR/README.md.USER
date > $DIR/README.md.ACTIVE
sed 's/^/\t -/' $DIR/README.md.USER >> $DIR/README.md.ACTIVE
printf "\n" >> $DIR/README.md.ACTIVE
cat $DIR/README.md.ACTIVE $DIR/README.md > $DIR/README.md.NEW
rm $DIR/README.md.{ACTIVE,USER}
mv $DIR/README.md.NEW $DIR/README.md

#Is a LICENSE needed?
[ $VERBOSE -eq 1 ] && printf "Generating a LICENSE...\n"
touch $DIR/LICENSE

#Create git repo 
[ $VERBOSE -eq 1 ] && printf "Creating the Git repository for this project...\n"
cd $DIR
git init
{
echo <<GIT
*.bmp
*.gif
*.jpg
*.png
*.mp4
*.mov
*.mkv
files/*
GIT
} > $DIR/.gitignore
git add .
git commit -m "Standard first commit."

#/etc/hosts should be modifiable via here
[ $VERBOSE -eq 1 ] && printf "Updating local /etc/hosts file...\n" 
printf "127.0.0.1\t$DEV_DOMAIN\t$DEV_ALIAS\n#End of file\n" >> $HOSTS_FILE


#Generate the scaffolding for a new VirtualHost for Lucee
HOST_CONTENT=$(cat <<LUCEE_HOST
\t\t<!-- #BEGIN:$DEV_DOMAIN -->\n\t\t<Host name="${DEV_DOMAIN}" appBase="webapps">\n\t\t\t<Context path="" docBase="${DIR}" />\n\t\t\t<Alias>${DEV_ALIAS}</Alias>\n\t\t</Host>\n\t\t<!-- #END:$DEV_DOMAIN -->\n
LUCEE_HOST
) #This is the end of variable declaration


#Create a new VirtualHost for Lucee
sed -i "{ s|\(<!-- ADD NEW HOSTS HERE -->\)|\1\n${HOST_CONTENT}| }" $LUCEE_CONF
