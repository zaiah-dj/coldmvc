/* --------------------------------------------- 
 *coldmvc.c* 

create all dirs
copy all files
parse the current json manifest
	use jsmn to parse and make sure it works correctly
create any orm files if needed
	create coldfusion's orm stupid files
open a server and start doing requests
	...
create forms? (that's pretty easy)
	create the html based on what's in the json file
 * --------------------------------------------- */
#include <stdio.h>
#include <string.h>
#include <errno.h>
/*This will probably change on Windows*/
#include <inttypes.h>
#include <unistd.h>
#include "lite.h"
#include "opt.h"

#define VERSION_MAJOR 0
#define VERSION_MINOR 1

#define PNAME "coldmvc"
#define BUILD_REPORT \
	fprintf(stderr, "%s (build v%d.%d) Compiled %s %s.\n", \
	PNAME, VERSION_MAJOR, VERSION_MINOR, __DATE__, __TIME__)

/*Configured by Make*/
/*Make sure you define stuff for Win32 too*/
#ifndef CONFIG_PATH
	#define CONFIG_PATH "/etc/"
#endif

#ifndef ASSETS_PATH
	#define ASSETS_PATH "/usr/local/share"
#endif

#ifndef DB_PATH
	#define DB_PATH "/var/local/coldmvc"
#endif

/*#ifndef REALPATH
 * #define realpath(dir) _fullpath(dir) //Win32
 *#elif
 * #define realpath(dir) _fullpath(dir) //Win32
 *#endif */

typedef struct Instance Instance;
struct Instance { /*An instance is a site and it's stuff*/
	FILE *json_handle;
	const char *path;
	const char *json_file;
	const char *name;
};

#define ugly(a,b) \
	#a#b

char *mkpath (char *dest, const char *path, const char *iname, int len) {
	char buf[2048]={0};
 	if ((int)path[0] < 0) //Bad requests
		return NULL;
	if (path[0] == '/')   //Most likely is absolute path
		return (dest = (char *)path);
	getcwd(dest, len);
	snprintf(&dest[strlen(dest) - 1], len - (strlen(dest)), "/%s", iname); 
	return dest;
}

_Bool create_instance (const char *path) {
	/*Try to create all the needed directories*/
	char tmp[2048]={0};	
	fprintf(stderr, "traversed path: %s\n", mkpath(tmp, path, "juice", 2048));
	
	/*Then copy (or link) the needed files from the paths above*/
	mkdir(tmp, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
	/*Open, read and write each file (copy)*/
	/*Optionally link some items*/	
	return 0;
}

_Bool open_instance (Instance *i, const char *path) {
	/*Fill the instance struct, so we can move around*/
	return 0;
}

_Bool create_orm_file (const char *path) {
	return 0;
}

/*Validates the JSON manifest at the top level of a directory*/
_Bool validate_json (const char *path) {
	return 0;
}

_Bool add_record ( ) {
	return 0;
}

Opt opts[] = {
	{ 0, "-c", "--create",        "Create an instance",       0 },
	{ 0, "-r", "--remove",        "Remove an instance.",      0 },
	{ 0, "-u", "--update",        "Update an instance",       0 },
	{ 0, "-v", "--validate",      "Validate an instance",       0 },
	{ 0, "-l", "--list",          "List instances",       0 },
	{ 0, NULL, "--list-backends", "List available backends",       0 },

	/*Configure/modify the new site with this stuff*/
	{ 0, "-a", "--at",            "Use <arg> as the home", 1, 
                             .callback=opt_set_filename },
	{ 0, "-b", "--backend",    "Use <arg> as the backend", 1, 
                             .callback=opt_set_filename },
	{ 0, "-d", "--datasource",    "Use <arg> as the datasource", 1, 
                             .callback=opt_set_filename },
	{ 0, "-n", "--name",       "Use <arg> as the application name.", 1,
                             .callback=opt_set_filename },
	{ 0, NULL, "--basedir",    "Use <arg> as the base directory " \
                             "of the new app.", 1,
                             .callback=opt_set_filename },
	{ 0, "-m", "--domain",     "Use <arg> as the site's domain " \
                             "name.", 1,
                             .callback=opt_set_filename },
	{ .sentinel=1 }
};

struct Settings {
	_Bool create, remove, update, validate, list, list_backends;
	char datasource[512];
	char at[512];
} settings = {
	0, 0, 0, 0, 0
};
       
int main (int argc, char *argv[]) {
	//Test the realpath command.
	//char np[2048]={0};
	
	BUILD_REPORT;
	eval_opts();
	Opt *eval=opts;

	//Evaluate all options
	while (!eval->sentinel) {
		/*Option evaluation*/
		int co=0;
		     if (optset("--create"))
			settings.create = 1;
		else if (optset("--at"))
			strncpy(settings.at, eval->v.s, strlen(eval->v.s));
		else if (optset("--remove"))  
			settings.remove = 1;
		else if (optset("--update")) 
			settings.update = 1;
		else if (optset("--validate")) 
			settings.validate = 1;
		else if (optset("--list")) 
			settings.list = 1;
		else if (optset("--list-backends")) 
			settings.list_backends = 1;
		else if (optset("--backend"))
			strncpy(settings.datasource, eval->v.s, strlen(eval->v.s));
		eval++;
	}

	//List all instances on a system with SQLite
	if (settings.list)
		;
	//create instances
	else if (settings.create)
		create_instance( settings.at );
	//remove instances
	else if (settings.remove)
		;
	//update instances
	else if (settings.update)
		;
	//create jsons? (this should check them too and give you a list on the command line)
	else if (settings.validate)
		;
	//create orms
	//create views
	return 0;
}

